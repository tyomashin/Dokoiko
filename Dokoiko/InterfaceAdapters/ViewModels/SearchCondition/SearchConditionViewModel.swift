//
//  SearchConditionViewModel.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/07.
//

import Foundation

/// 検索条件画面のViewModelが準拠するプロトコル
protocol SearchConditionViewModelProtocol: AnyObject {}

/// 検索条件画面のViewModel
class SearchConditionViewModel: SearchConditionViewModelProtocol {
    private weak var view: SearchConditionVCProtocol?
    private let router: SearchConditionRouterProtocol

    init(view: SearchConditionVCProtocol, router: SearchConditionRouterProtocol) {
        self.view = view
        self.router = router
    }

    deinit {
        print("deinit SearchConditionViewModel")
    }
}
