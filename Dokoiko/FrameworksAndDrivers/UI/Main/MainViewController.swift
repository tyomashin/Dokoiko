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

        let hoge = WikiDataUseCase(wikiDataGateway: WikiDataGateway(wikiDataClient: WikiDataClient()))
        hoge.getWikiData(wikiCode: "Q750569")
            .subscribe(onNext: { result in
                print(result)
            })
    }

    internal func inject(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
    }
}