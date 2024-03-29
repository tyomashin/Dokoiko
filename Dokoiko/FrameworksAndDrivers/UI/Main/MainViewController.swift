//
//  MainViewController.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/01/12.
//

import RxCocoa
import RxSwift
import UIKit

/// メイン画面が準拠するプロトコル
/// sourcery: AutoMockable
protocol MainVCProtocol: AnyObject {
    /// リストのセルが選択されたときのイベント
    var itemSelected: Observable<Int> { get }
    /// 検索ボタンがタップされた時のイベント
    var tapSearchButton: Driver<Void> { get }
}

/// メイン画面
class MainViewController: UIViewController {
    private var viewModel: MainViewModelProtocol?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var buttonAreaView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var contentAreaView: MainContentView!
    @IBOutlet weak var contentAreaHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var contentAreaTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // NavigationBar を非表示にする。スワイプは有効にする
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        view.backgroundColor = Asset.backgroundColor.color
        headerView.backgroundColor = Asset.backgroundColor.color
        buttonAreaView.backgroundColor = Asset.backgroundColor.color
        contentAreaView.backgroundColor = Asset.backgroundColorPurple.color

        searchButton.setBackgroundImage(Asset.topPrimaryButton.image, for: .normal)
        searchButton.setBackgroundImage(Asset.topPrimaryButtonHighlight.image, for: .highlighted)
        searchButton.dropShadow(color: Asset.primaryDarkColor.color, opacity: 0.5, shadowOffset: .init(width: 5, height: 5))

        contentAreaView.dropShadow()

        if let viewModel = viewModel {
            // バインディング
            bindViewModel(viewModel: viewModel)
            viewModel.loadedViews()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillApper()
    }

    /// ViewModelを受け取るメソッドインジェクション
    /// - Parameter viewModel: メイン画面のViewModel
    internal func inject(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
    }

    /// ViewModelとバインディングする
    /// - Parameter viewModel: メイン画面のViewModel
    private func bindViewModel(viewModel: MainViewModelProtocol) {
        // 検索結果一覧のバインディング
        viewModel
            .searchHistoryList
            .drive(contentAreaView.rx.searchList)
            .disposed(by: disposeBag)
    }
}

extension MainViewController: MainVCProtocol {
    var itemSelected: Observable<Int> {
        contentAreaView.tableView.rx
            .itemSelected
            .map(\.row)
    }

    var tapSearchButton: Driver<Void> {
        searchButton.rx.tap.asDriver()
    }
}
