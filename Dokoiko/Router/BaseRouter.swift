//
//  BaseRouter.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/02.
//

import Foundation
import UIKit

/// アプリのどこからでも遷移可能な経路
enum BaseRouterNavigationDestination {
    case top
}

/// すべてのルーターが準拠するプロトコル
protocol BaseRouter {
    var window: UIWindow? { get }

    /// アプリ共通の経路へ遷移する
    /// - Parameter destination: 遷移経路
    func rootNavigation(to destination: BaseRouterNavigationDestination)
}

extension BaseRouter {
    var window: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        return scene?.window
    }

    /// アプリ共通の経路へ遷移する
    func rootNavigation(to destination: BaseRouterNavigationDestination) {
        switch destination {
        case .top:
            window?.rootViewController = nil
            _ = MainRouter()
        }
    }
}
