//
//  RecommendListRouter.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/07/14.
//

import Foundation
import UIKit

/// 遷移経路
enum RecommendListNavigationDestination {
    // 推薦リスト表示
    case recommendList(searchResult: SearchResultEntity)
    // 推薦スポット詳細表示
    case recommendDetail(spot: RecommendSpotEntity)
    // 閉じる
    case close
}

/// スポット推薦リスト画面からの画面遷移、およびDIを行う型が準拠するプロトコル
/// sourcery: AutoMockable
protocol RecommendListRouterProtocol: BaseRouter {
    /// 画面遷移を行う
    /// - Parameter destination: 遷移経路
    func navigate(to destination: RecommendListNavigationDestination)
}

/// スポット推薦リスト画面からの画面遷移、およびDIを行う
struct RecommendListRouter: RecommendListRouterProtocol {
    private let navigationController: UINavigationController

    init(parentNaV: UINavigationController, searchResult: SearchResultEntity) {
        let vc = StoryboardScene.RecommendList.initialScene.instantiate()
        navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.isModalInPresentation = true
        let spotSearchUseCase = SpotSearchUseCase(gateway: LocalSearchGateway(localSearchClient: LocalSearchAPIClient()))
        let locationGateway = LocationGateway(locationManager: LocationManager.shared)
        let viewModel = RecommendListViewModel(
            view: vc,
            router: self,
            searchResult: searchResult,
            spotSearchUseCase: spotSearchUseCase,
            locationGateway: locationGateway
        )
        vc.inject(viewModel: viewModel)
        parentNaV.present(navigationController, animated: true, completion: nil)
    }

    /// 画面遷移を行う
    func navigate(to destination: RecommendListNavigationDestination) {
        switch destination {
        case let .recommendList(searchResult: searchResult):
            let vc = StoryboardScene.RecommendList.initialScene.instantiate()
            let spotSearchUseCase = SpotSearchUseCase(gateway: LocalSearchGateway(localSearchClient: LocalSearchAPIClient()))
            let locationGateway = LocationGateway(locationManager: LocationManager.shared)
            let viewModel = RecommendListViewModel(
                view: vc,
                router: self,
                searchResult: searchResult,
                spotSearchUseCase: spotSearchUseCase,
                locationGateway: locationGateway
            )
            vc.inject(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: true)

        case let .recommendDetail(spot: spot):
            // TODO:
            break

        case .close:
            navigationController.dismiss(animated: true, completion: nil)
        }
    }
}
