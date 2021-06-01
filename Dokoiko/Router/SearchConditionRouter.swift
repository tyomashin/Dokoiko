//
//  SearchConditionRouter.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/06.
//

import Foundation
import UIKit

/// 遷移経路
enum SearchConditionNavigationDestination {
    // 検索条件画面
    case searchCondition
    // 検索中画面
    case searching
    // 戻る
    case back
}

/// 検索条件画面からの画面遷移、およびDIを行う型が準拠するプロトコル
protocol SearchConditionRouterProtocol: BaseRouter {
    /// 画面遷移を行う
    /// - Parameter destination: 遷移経路
    func navigate(to destination: SearchConditionNavigationDestination)
}

/// 検索条件画面からの画面遷移、およびDIを行う
struct SearchConditionRouter: SearchConditionRouterProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// 画面遷移を行う
    func navigate(to destination: SearchConditionNavigationDestination) {
        switch destination {
        case .searchCondition:
            let searchVC = StoryboardScene.SearchCondition.initialScene.instantiate()
            let appDataGateway = AppDataGateway()
            let locationManager = LocationManager.shared
            let locationGateway = LocationGateway(locationManager: locationManager)
            let searchViewModel = SearchConditionViewModel(
                view: searchVC,
                router: self,
                appDataGateway: appDataGateway,
                locationGateway: locationGateway
            )
            searchVC.inject(viewModel: searchViewModel)
            navigationController.pushViewController(searchVC, animated: true)

        case .searching:
            break

        case .back:
            navigationController.popViewController(animated: true)
        }
    }
}
