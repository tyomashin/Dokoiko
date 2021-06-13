//
//  SearchConditionViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/07.
//

import Foundation
import RxCocoa
import RxSwift

/// 検索条件画面のViewModelが準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchConditionViewModelProtocol: AnyObject {
    /// 検索方法の種別リスト
    var searchConditionTypeList: Driver<[SearchConditionData]> { get }
    /// 選択されている検索方法種別
    var selectedSearchConditionType: Driver<SearchConditionType> { get }
    /// 「都道府県から検索」の場合の検索条件
    var searchConditionPrefectures: Driver<SearchConditionPrefectures> { get }
    /// 「現在地の近くから検索」の場合の検索条件
    var searchConditionCurrentLocation: Driver<SearchConditionCurrentLocation> { get }
    /// 現在地の緯度経度
    var currentLocation: Driver<(lat: Double, lng: Double)> { get }
    /// 検索ボタンの活性化状態
    var searchPermission: Driver<Bool> { get }
    /// View読み込み完了後に呼ばれる
    func loadedViews()
}

/// 検索条件種別の情報
typealias SearchConditionData = (tag: Int, title: String)

/// 検索条件画面のViewModel
class SearchConditionViewModel: SearchConditionViewModelProtocol {
    private weak var view: SearchConditionVCProtocol?
    private let prefectureSearchViewModel: PrefectureSearchViewModelProtocol
    private let locationSearchViewModel: LocationSearchViewModelProtocol
    private let router: SearchConditionRouterProtocol
    private let disposeBag = DisposeBag()

    // 検索方法の種別リスト
    private let searchConditionTypeListRelay = BehaviorRelay<[SearchConditionData]>(value: [])
    var searchConditionTypeList: Driver<[SearchConditionData]> {
        searchConditionTypeListRelay.asDriver()
    }

    // 選択されている検索方法種別
    private let selectedSearchConditionTypeRelay = BehaviorRelay<SearchConditionType?>(value: nil)
    var selectedSearchConditionType: Driver<SearchConditionType> {
        selectedSearchConditionTypeRelay.asDriver().compactMap { $0 }
    }

    // 「都道府県から検索」の場合の検索条件
    var searchConditionPrefectures: Driver<SearchConditionPrefectures> {
        prefectureSearchViewModel.searchConditionPrefectures
    }

    // 「現在地の近くから検索」の場合の検索条件
    var searchConditionCurrentLocation: Driver<SearchConditionCurrentLocation> {
        locationSearchViewModel.searchConditionLocation
    }

    // 現在地の緯度経度
    var currentLocation: Driver<(lat: Double, lng: Double)> {
        locationSearchViewModel.currentLocation
    }

    // 検索ボタンの活性化状態
    private let searchPermissionRelay = BehaviorRelay<Bool>(value: false)
    var searchPermission: Driver<Bool> {
        searchPermissionRelay.asDriver()
    }

    init(
        view: SearchConditionVCProtocol,
        router: SearchConditionRouterProtocol,
        appDataGateway: AppDataGatewayProtocol,
        locationGateway: LocationGatewayProtocol
    ) {
        self.view = view
        self.router = router
        prefectureSearchViewModel = PrefectureSearchViewModel(appDataGateway: appDataGateway)
        locationSearchViewModel = LocationSearchViewModel(locationGateway: locationGateway)
    }

    /// 検索方法種別リストの初期化
    private func initSearchConditionTypeList() {
        var results = [SearchConditionData]()
        for condition in SearchConditionType.allCases {
            let entity: SearchConditionData = (condition.tag, condition.title)
            results.append(entity)
        }
        searchConditionTypeListRelay.accept(results)
    }

    /// Viewのイベントを購読
    private func bindViews() {
        guard let view = view else { return }
        // 戻るボタンタップ時に呼ばれる
        view.tapBackButton
            .emit(onNext: { [weak self] in
                self?.router.navigate(to: .back)
            })
            .disposed(by: disposeBag)

        // 検索条件が選択された時に呼ばれる
        view.selectedSearchCondition
            .drive(onNext: { [weak self] selectedTag in
                self?.changeSearchCondition(selectedTag: selectedTag)
            })
            .disposed(by: disposeBag)

        // 「都道府県から検索」のViewModel内でViewのイベントを購読
        prefectureSearchViewModel.bindViews(
            areaSelectedIndex: view.areaSelectedIndex,
            prefectureSelectedIndex: view.prefectureSelectedIndex
        )

        // 「現在地から検索」のViewModel内でViewのイベントを購読
        locationSearchViewModel.bindViews(
            selectedLocation: view.selectedLocation,
            selectedRadius: view.selectedRadius
        )

        view.tapSearchButton
            .emit(onNext: { [weak self] in
                self?.searchCity()
            })
            .disposed(by: disposeBag)
    }

    /// View読み込み完了後に呼ばれる
    func loadedViews() {
        // Viewとバインディング
        bindViews()
        // 各種初期化
        initSearchConditionTypeList()
    }

    /// 検索条件の変更
    private func changeSearchCondition(selectedTag: Int) {
        guard let searchConditionType = SearchConditionType.allCases.first(where: { $0.tag == selectedTag }) else {
            return
        }
        selectedSearchConditionTypeRelay.accept(searchConditionType)
        // 検索ボタンの活性化状態を切り替える
        checkSearchPermission()
    }

    /// 検索ボタンの活性化判定
    private func checkSearchPermission() {
        // まだ検索方法が選択されていない場合
        guard let conditionType = selectedSearchConditionTypeRelay.value else {
            searchPermissionRelay.accept(false)
            return
        }
        switch conditionType {
        case .prefectures:
            searchPermissionRelay.accept(true)

        case .currentLocation:
            searchPermissionRelay.accept(true)
        }
    }

    /// 検索ボタンタップ時の処理
    private func searchCity() {
        guard let searchConditionType = selectedSearchConditionTypeRelay.value else {
            return
        }
        // 検索条件オブジェクトを生成
        let conditionData: SearchConditionDataEntity
        switch searchConditionType {
        case .prefectures:
            guard let condition = prefectureSearchViewModel.searchConditionPrefecturesData else {
                return
            }
            conditionData = .prefectures(condition: condition)

        case .currentLocation:
            conditionData = .currentLocation(condition: locationSearchViewModel.searchConditionData)
        }

        // 画面遷移する
        router.navigate(to: .searching(conditionData: conditionData))
        print(conditionData)
    }
}
