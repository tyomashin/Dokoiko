//
//  MainViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/01/12.
//

import UIKit

class MainViewController: UIViewController {
    private var viewModel: MainViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // NavigationBar を非表示にする。スワイプは有効にする
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    internal func inject(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
    }
}
