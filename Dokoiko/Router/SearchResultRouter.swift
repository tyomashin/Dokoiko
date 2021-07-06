//
//  SearchResultRouter.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/24.
//

import Foundation
import MapKit
import UIKit

/// 遷移経路
enum SearchResultNavigationDestination {
    // 検索結果画面（ローディング画面から遷移）
    case searchResultFromLoading(searchResult: SearchResultEntity, animation: Bool)
    // 検索結果画面（メイン画面から遷移）
    case searchResult(searchResult: SearchResultEntity)
    // アプリ内推薦画面に遷移
    case recommendSpot(searchResult: SearchResultEntity)
    // 閉じる（戻る）
    case close
    // 検索文字列をもとにGoogleMapへ遷移する
    case transitionGoogleMap(query: String)
    // 検索文字列をもとにAppleMapへ遷移する
    case transitionAppleMap(query: String)
    // 緯度経度をもとにMapへ遷移する
    case transitionAppleMapFromLocation(lat: Double, lng: Double, cityName: String)
    // Webブラウザを開く
    case transitionWebBrowser(query: String)
}

/// 検索結果画面からの画面遷移、およびDIを行う型が準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchResultRouterProtocol: BaseRouter {
    /// 画面遷移を行う
    /// - Parameter destination: 遷移経路
    func navigate(to destination: SearchResultNavigationDestination)
}

/// 検索結果画面からの画面遷移、およびDIを行う
struct SearchResultRouter: SearchResultRouterProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// 画面遷移を行う
    func navigate(to destination: SearchResultNavigationDestination) {
        switch destination {
        case let .searchResultFromLoading(searchResult: searchResult, animation: animation):
            let searchResultVC = StoryboardScene.SearchResult.initialScene.instantiate()
            let viewModel = SearchResultViewModel(view: searchResultVC, router: self, isAnimation: animation, searchResult: searchResult)
            searchResultVC.inject(viewModel: viewModel)
            // 直前のローディング画面を置き換え
            var vcs: [UIViewController] = navigationController.viewControllers.dropLast()
            vcs.append(searchResultVC)
            // アニメーションする場合
            if animation {
                navigationController.fade(viewControllers: vcs)
            }
            // 通常遷移の場合
            else {
                navigationController.pushViewController(searchResultVC, animated: true)
            }

        case let .searchResult(searchResult: searchResult):
            let searchResultVC = StoryboardScene.SearchResult.initialScene.instantiate()
            let viewModel = SearchResultViewModel(view: searchResultVC, router: self, isAnimation: false, searchResult: searchResult)
            searchResultVC.inject(viewModel: viewModel)
            navigationController.pushViewController(searchResultVC, animated: true)

        case let .recommendSpot(searchResult: searchResult):
            // TODO:
            break

        case .close:
            navigationController.popViewController(animated: true)

        case let .transitionGoogleMap(query: query):
            openGoogleMap(query: query)

        case let .transitionAppleMap(query: query):
            openAppleMap(query: query)

        case let .transitionAppleMapFromLocation(lat: lat, lng: lng, cityName: cityName):
            let mkMapItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng)))
            mkMapItem.name = cityName
            mkMapItem.openInMaps(launchOptions: nil)

        case let .transitionWebBrowser(query: query):
            openWebBrowser(query: query)
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

    /// AppleMapを開く
    private func openAppleMap(query: String) {
        guard let url = URL(string: "maps://maps.apple.com/") else {
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "address", value: query))
        components?.queryItems = queryItems
        if let newUrl = components?.url {
            UIApplication.shared.open(newUrl)
        }
    }

    /// GoogleMapを開く
    private func openGoogleMap(query: String) {
        guard let url = URL(string: "comgooglemaps://") else {
            // googleMapがない場合はAppleMapへ遷移
            navigate(to: .transitionAppleMap(query: query))
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: query))
        components?.queryItems = queryItems
        if let newUrl = components?.url {
            UIApplication.shared.open(newUrl)
        } else {
            // googleMapが開けない場合はAppleMapへ遷移
            navigate(to: .transitionAppleMap(query: query))
        }
    }
}
