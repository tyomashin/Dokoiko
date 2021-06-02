//
//  PrefectureSearchViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/30.
//

import Foundation
import RxCocoa
import RxSwift

/// 「都道府県から検索」のViewModelが準拠するプロトコル
protocol PrefectureSearchViewModelProtocol {
    /// 検索条件
    var searchConditionPrefectures: Driver<SearchConditionPrefectures> { get }
    /// 親ViewModelに渡すための検索条件オブジェクト
    var searchConditionPrefecturesData: SearchConditionPrefectures? { get }
    /// Viewとバインディングする
    /// - Parameters:
    ///   - areaSelectedIndex: エリアが選択された時のイベント
    ///   - prefectureSelectedIndex: 都道府県が選択された時のイベント
    func bindViews(areaSelectedIndex: Driver<Int>, prefectureSelectedIndex: Driver<Int>)
}

/// 「都道府県から検索」のViewModel
class PrefectureSearchViewModel: PrefectureSearchViewModelProtocol {
    private let appDataGateway: AppDataGatewayProtocol
    private let disposeBag = DisposeBag()

    // 検索条件のオブジェクト
    private let searchConditionPrefecturesRelay = BehaviorRelay<SearchConditionPrefectures?>(value: nil)
    var searchConditionPrefectures: Driver<SearchConditionPrefectures> {
        searchConditionPrefecturesRelay.asDriver().compactMap { $0 }
    }

    // 親ViewModelに渡すための検索条件オブジェクト
    var searchConditionPrefecturesData: SearchConditionPrefectures? {
        searchConditionPrefecturesRelay.value
    }

    init(appDataGateway: AppDataGatewayProtocol) {
        self.appDataGateway = appDataGateway

        setInitCondition()
    }

    /// 検索条件オブジェクトの初期化
    private func setInitCondition() {
        appDataGateway.searchConditionPrefectures
            .subscribe(onSuccess: { [weak self] data in
                let result: SearchConditionPrefectures
                if let data = data {
                    result = data
                } else {
                    result = SearchConditionPrefectures(
                        regionBlockList: RegionalBlockType.allCases,
                        selectedRegionBlockIndex: 2,
                        prefecturesList: RegionalBlockType.allCases[2].prefectures,
                        selectedPrefectureIndex: 5
                    )
                }
                self?.searchConditionPrefecturesRelay.accept(result)
            })
            .disposed(by: disposeBag)
    }

    /// Viewとバインディングする
    func bindViews(areaSelectedIndex: Driver<Int>, prefectureSelectedIndex: Driver<Int>) {
        // エリアが選択された時に呼ばれる
        areaSelectedIndex
            .drive(onNext: { [weak self] selectedIndex in
                self?.changeAreaInPrefectureSearch(selectedIndex: selectedIndex)
            })
            .disposed(by: disposeBag)

        // 都道府県が選択された時に呼ばれる
        prefectureSelectedIndex
            .drive(onNext: { [weak self] selectedIndex in
                self?.changePrefectureInPrefectureSearch(selectedIndex: selectedIndex)
            })
            .disposed(by: disposeBag)
    }

    /// 「都道府県から検索」でリストからエリアが選択された時の処理
    private func changeAreaInPrefectureSearch(selectedIndex: Int) {
        guard var currentCondition = searchConditionPrefecturesRelay.value else {
            return
        }
        currentCondition.selectedRegionBlockIndex = selectedIndex
        let prefectures = RegionalBlockType.allCases[selectedIndex].prefectures
        currentCondition.prefecturesList = prefectures
        currentCondition.selectedPrefectureIndex = 0
        searchConditionPrefecturesRelay.accept(currentCondition)
    }

    /// 「都道府県から検索」でリストから都道府県が選択された時の処理
    private func changePrefectureInPrefectureSearch(selectedIndex: Int) {
        guard var currentCondition = searchConditionPrefecturesRelay.value else {
            return
        }
        currentCondition.selectedPrefectureIndex = selectedIndex
        searchConditionPrefecturesRelay.accept(currentCondition)
    }
}
