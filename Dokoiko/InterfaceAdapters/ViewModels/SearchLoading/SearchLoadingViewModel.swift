//
//  SearchLoadingViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/13.
//

import Foundation
import RxCocoa
import RxSwift

/// 検索ローディング画面のViewModelが準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchLoadingViewModelProtocol: AnyObject {
    /// ローディング状態
    var loadingState: Driver<LoadingState> { get }
    /// View読み込み完了後に呼ばれる
    func loadedViews()
}

/// 検索ローディング画面のViewModel
class SearchLoadingViewModel: SearchLoadingViewModelProtocol {
    // 場所の検索結果格納用の型
    typealias SearchResultData = (prefecture: PrefectureType, cityName: String)

    private weak var view: SearchLoadingVCProtocol?
    private let router: SearchLoadingRouterProtocol
    private let disposeBag = DisposeBag()
    private let searchCondition: SearchConditionDataEntity
    private let resasUseCase: ResasUseCaseProtocol
    private let geoDBUseCase: GeoDBUseCaseProtocol
    private let wikiDataUseCase: WikiDataUseCaseProtocol
    private let searchResultUseCase: SearchResultUseCaseProtocol

    // ローディング状態のイベント
    private let loadingStateRelay = BehaviorRelay<LoadingState>(value: .idle)
    var loadingState: Driver<LoadingState> {
        loadingStateRelay.asDriver()
    }

    // 検索結果格納用
    private var searchResult: SearchResultData?

    init(
        view: SearchLoadingVCProtocol,
        router: SearchLoadingRouterProtocol,
        searchCondition: SearchConditionDataEntity,
        resasUseCase: ResasUseCaseProtocol,
        geoDBUseCase: GeoDBUseCaseProtocol,
        wikiDataUseCase: WikiDataUseCaseProtocol,
        searchResultUseCase: SearchResultUseCaseProtocol
    ) {
        self.view = view
        self.router = router
        self.searchCondition = searchCondition
        self.resasUseCase = resasUseCase
        self.geoDBUseCase = geoDBUseCase
        self.wikiDataUseCase = wikiDataUseCase
        self.searchResultUseCase = searchResultUseCase
    }

    /// View読み込み完了後に呼ばれる
    func loadedViews() {
        // Viewとバインディング
        bindViews()
        // 各種初期化
        loadingStateRelay.accept(.loading)

        // 場所の検索処理開始
        searchCity(condition: searchCondition)
    }

    /// Viewのイベントを購読
    private func bindViews() {
        guard let view = view else {
            return
        }

        // 完了アニメーションが終了した時のイベントを購読
        view
            .completionAnmation
            .emit(onNext: { [weak self] isCompletion in
                guard let self = self else {
                    return
                }
                // 検索結果画面に遷移する
                if isCompletion, let searchResult = self.searchResult {
                    self.router.navigate(to: .searchResult(prefecture: searchResult.prefecture, cityName: searchResult.cityName))
                }
            })
            .disposed(by: disposeBag)
    }

    /// 場所の検索処理を行う
    /// - Parameter condition: 検索条件
    private func searchCity(condition: SearchConditionDataEntity) {
        switch condition {
        // 都道府県から検索
        case let .prefectures(condition: condition):
            searchCityFromPrefectures(condition: condition)
        // 現在地付近から検索
        case let .currentLocation(condition: condition):
            searchCityFromLocation(condition: condition)
        }
    }

    /// 都道府県から検索
    private func searchCityFromPrefectures(condition: SearchConditionPrefectures) {
        let prefecture = condition.prefecturesList[condition.selectedPrefectureIndex]
        // API を実行して都道府県内の場所一覧を取得するためのObservable
        let citySearchObservable = resasUseCase.getCitiesInPrefecture(prefCode: "\(prefecture.prefCode)").asObservable()
        // 1秒間を数えるタイマー
        let timeIntervalObservable = Observable<Int>.timer(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)

        // 一瞬で完了すると表示が不自然になるため最低１秒間はローディング表示するようにしている
        Observable
            .combineLatest(citySearchObservable, timeIntervalObservable, resultSelector: { result, _ in
                result
            })
            .subscribe(onNext: { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                // API成功時
                case let .success(response: response):
                    // 場所を正常に取得できた場合
                    if let searchResult = response.result?.shuffled().first,
                       let prefCode = searchResult.prefCode,
                       let prefecture = PrefectureType.allCases.first(where: { $0.prefCode == prefCode }),
                       let cityName = searchResult.cityName {
                        // 検索結果を保持してviewに完了通知
                        self.searchResult = (prefecture, cityName)
                        self.saveSearchResult()
                        self.loadingStateRelay.accept(.completion)
                    }
                    // 検索結果が有効でない場合
                    else {
                        self.loadingStateRelay.accept(.error(message: L10n.Dialog.Message.Error.SearchLoading.empty))
                    }

                // API失敗時
                case .error(error: _):
                    self.loadingStateRelay.accept(.error(message: L10n.Dialog.Message.Error.searchLoading))
                }
            })
            .disposed(by: disposeBag)
    }

    /// 現在地付近から検索
    private func searchCityFromLocation(condition: SearchConditionCurrentLocation) {
        // APIでエリア内の場所を取得する
        geoDBUseCase
            .getCitiesInArea(lat: condition.lat, lng: condition.lng, radiusKM: Double(condition.radius))
            .subscribe(onSuccess: { [weak self] result in
                switch result {
                // API成功時
                case let .success(response: response):
                    // 場所を取得できた場合
                    if let searchResult = response.data?.shuffled().first,
                       let wikiDataId = searchResult.wikiDataId,
                       let prefCode = searchResult.regionCode,
                       let prefecture = PrefectureType.allCases.first(where: { prefCode == "\($0.prefCode)" }) {
                        self?.searchCityDetail(wikiDataId: wikiDataId, prefecture: prefecture)
                    }
                    // 検索結果が有効でない場合
                    else {
                        self?.loadingStateRelay.accept(.error(message: L10n.Dialog.Message.Error.SearchLoading.empty))
                    }

                // API失敗時
                case .error(error: _):
                    self?.loadingStateRelay.accept(.error(message: L10n.Dialog.Message.Error.searchLoading))
                }
            })
            .disposed(by: disposeBag)
    }

    /// wikiDataIDから場所の情報を取得する
    private func searchCityDetail(wikiDataId: String, prefecture: PrefectureType) {
        // API実行して場所名を取得する
        wikiDataUseCase
            .getWikiData(wikiCode: wikiDataId)
            .subscribe(onSuccess: { [weak self] response in
                switch response {
                // API成功時
                case let .success(response: response):
                    // 場所名が正常に取得できた場合
                    if let cityName = response.entities?[wikiDataId]?.labels?.ja?.value {
                        self?.searchResult = (prefecture: prefecture, cityName: cityName)
                        self?.saveSearchResult()
                        self?.loadingStateRelay.accept(.completion)
                    }
                    // 検索結果が有効でない場合
                    else {
                        self?.loadingStateRelay.accept(.error(message: L10n.Dialog.Message.Error.SearchLoading.empty))
                    }

                // API失敗時
                case .error(error: _):
                    self?.loadingStateRelay.accept(.error(message: L10n.Dialog.Message.Error.searchLoading))
                }
            })
            .disposed(by: disposeBag)
    }

    /// 検索結果をDBに保存する
    private func saveSearchResult() {
        guard let searchResult = searchResult else {
            return
        }
        searchResultUseCase.saveCitySearchResult(prefCode: searchResult.prefecture.prefCode, cityName: searchResult.cityName)
    }
}
