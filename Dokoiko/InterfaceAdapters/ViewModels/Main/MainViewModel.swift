//
//  MainViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/03/25.
//

import Foundation
import RxCocoa
import RxSwift

/// メイン画面のViewModelが準拠するプロトコル
/// sourcery: AutoMockable
protocol MainViewModelProtocol: AnyObject {
    /// アプリ初回起動フラグ
    // var initialFlag: Driver<Bool> { get }
    /// 検索履歴リスト
    var searchHistoryList: Driver<[SearchResultEntity]> { get }
    /// View読み込み完了後に呼ばれる
    func loadedViews()
    /// View表示時に呼ばれる
    func viewWillApper()
}

/// メイン画面のViewModel
class MainViewModel: MainViewModelProtocol {
    /// 初回起動フラグ
    /*
     private let initialFlagRelay = BehaviorRelay<Bool>(value: false)
     var initialFlag: Driver<Bool> {
     initialFlagRelay.asDriver()
     }
     */

    /// 検索履歴リスト
    private let searchHistoryListRelay = BehaviorRelay<[SearchResultEntity]>(value: [])
    var searchHistoryList: Driver<[SearchResultEntity]> {
        searchHistoryListRelay.asDriver()
    }

    private let disposeBag = DisposeBag()
    private weak var view: MainVCProtocol?
    private let router: MainRouterProtocol
    private let searchResultUseCase: SearchResultUseCaseProtocol

    init(view: MainVCProtocol, router: MainRouterProtocol, searchResultUseCase: SearchResultUseCaseProtocol) {
        self.view = view
        self.router = router
        self.searchResultUseCase = searchResultUseCase

        // 初期化処理
        initialize()
    }

    /// 初期化処理
    private func initialize() {
        // 検索履歴の取得
        updateSearchResults()
    }

    /// Viewのイベントを購読
    private func bindViews() {
        guard let view = view else { return }
        // TableViewのセルが選択された時に呼ばれる
        view.itemSelected
            .subscribe(onNext: { [weak self] row in
                guard let self = self else { return }
                if self.searchHistoryListRelay.value.indices.contains(row) {
                    // 検索結果画面に遷移
                    self.router.navigate(to: .searchResult(searchResult: self.searchHistoryListRelay.value[row]))
                }
            })
            .disposed(by: disposeBag)

        // 検索ボタンタップ時に呼ばれる
        view.tapSearchButton
            .drive(onNext: { [weak self] in
                // 検索条件画面に遷移する
                self?.router.navigate(to: .searchCondition)
            })
            .disposed(by: disposeBag)
    }

    /// View読み込み完了後に呼ばれる
    func loadedViews() {
        bindViews()
    }

    /// View表示時に呼ばれる
    func viewWillApper() {
        // 検索履歴の際取得
        updateSearchResults()
    }

    /// 検索履歴の取得
    private func updateSearchResults() {
        searchResultUseCase.getCitySearchResult()
            .subscribe(onSuccess: { [weak self] result in
                switch result {
                case let .success(response):
                    self?.searchHistoryListRelay.accept(response)

                case .failure:
                    self?.searchHistoryListRelay.accept([])
                }
            })
            .disposed(by: disposeBag)
    }
}
