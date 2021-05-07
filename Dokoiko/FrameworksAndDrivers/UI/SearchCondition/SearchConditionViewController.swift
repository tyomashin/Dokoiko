//
//  SearchConditionViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/04.
//

import UIKit

/// 検索条件画面が準拠するプロトコル
protocol SearchConditionVCProtocol: AnyObject {}

/// 検索条件画面
class SearchConditionViewController: UIViewController {
    private var viewModel: SearchConditionViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /// ViewModelを受け取るメソッドインジェクション
    /// - Parameter viewModel: 検索条件画面のViewModel
    internal func inject(viewModel: SearchConditionViewModelProtocol) {
        self.viewModel = viewModel
    }

    deinit {
        print("deinit SearchConditionViewController")
    }
}

extension SearchConditionViewController: SearchConditionVCProtocol {}
