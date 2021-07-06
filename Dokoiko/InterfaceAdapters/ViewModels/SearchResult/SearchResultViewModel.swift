//
//  SearchResultViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/24.
//

import Foundation
import RxCocoa
import RxSwift

/// 検索結果画面のViewModelが準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchResultViewModelProtocol: AnyObject {
    /// 検索結果とアニメーション可否情報
    var animationData: Driver<(isAnimation: Bool, cityName: String)> { get }
    /// View読み込み完了後に呼ばれる
    func loadedViews()
}

/// 検索結果画面のViewModel
class SearchResultViewModel: SearchResultViewModelProtocol {
    typealias AnimationData = (isAnimation: Bool, cityName: String)
    typealias SearchResultData = (prefecture: PrefectureType, cityName: String)

    private weak var view: SearchResultVCProtocol?
    private let router: SearchResultRouterProtocol
    // 検索結果表示時にアニメーションするかどうかのフラグ
    private let isAnimation: Bool
    // 検索結果
    // private let searchResult: SearchResultData
    private let searchResult: SearchResultEntity
    private let disposeBag = DisposeBag()
    // 検索結果とアニメーション可否情報
    private let animationDataRelay = BehaviorRelay<AnimationData?>(value: nil)
    var animationData: Driver<(isAnimation: Bool, cityName: String)> {
        animationDataRelay.asDriver().compactMap { $0 }
    }

    init(
        view: SearchResultVCProtocol,
        router: SearchResultRouterProtocol,
        isAnimation: Bool,
        searchResult: SearchResultEntity
    ) {
        self.view = view
        self.router = router
        self.isAnimation = isAnimation
        self.searchResult = searchResult
    }

    /// Viewのイベントを購読
    private func bindViews() {
        guard let view = view else { return }

        // 閉じるボタンがタップされた時の処理
        view.tapCloseButton
            .drive(onNext: { [weak self] in
                self?.router.navigate(to: .close)
            })
            .disposed(by: disposeBag)

        // マップボタンがタップされた時の処理
        view.tapMapButton
            .drive(onNext: { [weak self] in
                guard let self = self, let prefecture = PrefectureType.allCases.first(where: { $0.prefCode == self.searchResult.prefCode }) else {
                    return
                }
                // マップ画面に遷移
                let query = prefecture.name + self.searchResult.cityName
                self.router.navigate(to: .transitionGoogleMap(query: query))
            })
            .disposed(by: disposeBag)

        // Web検索ボタンがタップされた時の処理
        view.tapWebSearchButton
            .drive(onNext: { [weak self] in
                guard let self = self, let prefecture = PrefectureType.allCases.first(where: { $0.prefCode == self.searchResult.prefCode }) else {
                    return
                }
                // マップ画面に遷移
                let query = L10n.SearchResult.WebSearch.queryDefault + "+" + prefecture.name + self.searchResult.cityName
                self.router.navigate(to: .transitionWebBrowser(query: query))
            })
            .disposed(by: disposeBag)

        // アプリ内推薦ボタンがタップされた時の処理
        view.tapRecommendButton
            .drive(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                // アプリ内推薦画面に遷移
                self.router.navigate(to: .recommendSpot(searchResult: self.searchResult))
            })
            .disposed(by: disposeBag)
    }

    /// 初期データ構築
    private func makeInitData() {
        // 検索結果とアニメーション情報をViewに通知
        let tmpAnimationData: AnimationData = (isAnimation: isAnimation, cityName: searchResult.cityName)
        animationDataRelay.accept(tmpAnimationData)
    }

    /// View読み込み完了後に呼ばれる
    func loadedViews() {
        // Viewとバインディング
        bindViews()
        // 初期データ構築
        makeInitData()
    }
}
