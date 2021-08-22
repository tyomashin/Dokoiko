//
//  RecommendDetailRouter.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/08/09.
//

import Foundation
import UIKit

/// 遷移経路
enum RecommendDetailNavigationDestination {
    // 推薦詳細表示
    case recommendDetail(spotEntity: RecommendSpotEntity, spotCategory: SpotCategory)
    // 戻る
    case back
    // 閉じる
    case close
    // Webサイトを開く
    case transitionWebSearch(query: String)
    // GoogleMapを開く（経路案内）
    case transitionGoogleMap(spotLat: Double, spotLng: Double)
    // クーポンURLを開く
    case transitionCoupon(urlStr: String)
}

/// 推薦詳細画面からの画面遷移、およびDIを行う型が準拠するプロトコル
/// sourcery: AutoMockable
protocol RecommendDetailRouterProtocol: BaseRouter {
    /// 画面遷移を行う
    /// - Parameter destination: 遷移経路
    func navigate(to destination: RecommendDetailNavigationDestination)
}

class RecommendDetailRouter: RecommendDetailRouterProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// 画面遷移を行う
    func navigate(to destination: RecommendDetailNavigationDestination) {
        switch destination {
        case let .recommendDetail(spotEntity: spotEntity, spotCategory: spotCategory):
            let recommendVC = StoryboardScene.RecommendDetail.initialScene.instantiate()
            let viewModel = RecommendDetailViewModel(
                view: recommendVC,
                router: self,
                spotEntity: spotEntity,
                spotCategory: spotCategory
            )
            recommendVC.inject(viewModel: viewModel)
            navigationController.pushViewController(recommendVC, animated: true)

        case .back:
            navigationController.popViewController(animated: true)

        case .close:
            navigationController.dismiss(animated: true, completion: nil)

        case let .transitionWebSearch(query: query):
            openWebBrowser(query: query)

        case let .transitionGoogleMap(spotLat: spotLat, spotLng: spotLng):
            openGoogleMap(spotLat: spotLat, spotLng: spotLng)

        case let .transitionCoupon(urlStr: urlStr):
            openWebBrowser(urlStr: urlStr)
        }
    }

    /// Webブラウザを開く
    private func openWebBrowser(query: String) {
        guard let url = URL(string: "https://www.google.com/search") else {
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: query))
        components?.queryItems = queryItems
        if let newUrl = components?.url {
            UIApplication.shared.open(newUrl)
        }
    }

    /// Webブラウザを開く
    private func openWebBrowser(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        UIApplication.shared.open(url)
    }

    /// GoogleMapを開く
    private func openGoogleMap(spotLat: Double, spotLng: Double) {
        guard let url = URL(string: "comgooglemaps://"), UIApplication.shared.canOpenURL(url) else {
            // WebブラウザでGoogleMapを開く
            let url = "https://www.google.com/maps/dir/?api=1&destination=\(spotLat),\(spotLng)&travelmode=driving&dir_action=navigate"
            openWebBrowser(urlStr: url)
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "daddr", value: "\(spotLat),\(spotLng)"))
        queryItems.append(URLQueryItem(name: "directionsmode", value: "driving"))
        components?.queryItems = queryItems
        if let newUrl = components?.url {
            UIApplication.shared.open(newUrl)
        }
    }
}
