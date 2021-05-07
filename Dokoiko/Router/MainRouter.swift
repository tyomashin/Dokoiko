//
//  MainRouter.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/02.
//

import Foundation
import UIKit

/// 遷移経路
enum MainNavigationDestination {
    // トップ画面
    case top
    // 検索条件画面
    case searchCondition
    // 戻る
    case back
}

/// メイン画面からの画面遷移、およびDIを行う型が準拠するプロトコル
protocol MainRouterProtocol: BaseRouter {
    /// 画面遷移
    /// - Parameter destination: 遷移経路
    func navigate(to destination: MainNavigationDestination)
}

/// メイン画面からの画面遷移、およびDIを行う
struct MainRouter: MainRouterProtocol {
    private let navigationController: UINavigationController

    init() {
        // 初期表示画面の作成、DI、およびルートViewControllerに設定
        let mainVC = StoryboardScene.Main.initialScene.instantiate()
        navigationController = UINavigationController(rootViewController: mainVC)

        let database = RealmRepository()
        let dataBaseGateway = DataBaseGateway(database: database)
        let searchResultUseCase = SearchResultUseCase(gateway: dataBaseGateway)
        let mainViewModel = MainViewModel(view: mainVC, router: self, searchResultUseCase: searchResultUseCase)
        mainVC.inject(viewModel: mainViewModel)

        window?.rootViewController = navigationController
    }

    /// 画面遷移
    func navigate(to destination: MainNavigationDestination) {
        switch destination {
        case .top:
            let mainVC = StoryboardScene.Main.initialScene.instantiate()
            let database = RealmRepository()
            let dataBaseGateway = DataBaseGateway(database: database)
            let searchResultUseCase = SearchResultUseCase(gateway: dataBaseGateway)
            let mainViewModel = MainViewModel(view: mainVC, router: self, searchResultUseCase: searchResultUseCase)
            mainVC.inject(viewModel: mainViewModel)
            navigationController.pushViewController(mainVC, animated: true)
            
        // 検索条件画面に遷移する
        case .searchCondition:
            let searchRouter = SearchConditionRouter(navigationController: navigationController)
            searchRouter.navigate(to: .searchCondition)

        case .back:
            navigationController.popViewController(animated: true)
        }
    }
}
