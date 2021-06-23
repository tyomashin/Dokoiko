//
//  SearchLoadingRouter.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/06/13.
//

import Foundation
import UIKit

/// 遷移経路
enum SearchLoadingNavigationDestination {
    // 検索中画面
    case searching(conditionData: SearchConditionDataEntity)
    // 検索結果画面
    case searchResult(prefecture: PrefectureType, cityName: String)
    // 戻る
    case back
}

/// 検索条件画面からの画面遷移、およびDIを行う型が準拠するプロトコル
/// sourcery: AutoMockable
protocol SearchLoadingRouterProtocol: BaseRouter {
    /// 画面遷移を行う
    /// - Parameter destination: 遷移経路
    func navigate(to destination: SearchLoadingNavigationDestination)
}

/// ローディング画面からの画面遷移、およびDIを行う
struct SearchLoadingRouter: SearchLoadingRouterProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// 画面遷移を行う
    func navigate(to destination: SearchLoadingNavigationDestination) {
        switch destination {
        case let .searching(conditionData: conditionData):
            let loadingVC = StoryboardScene.SearchLoading.initialScene.instantiate()

            let resasApiClient = ResasAPIClient()
            let resasGateway = ResasGateway(resasAPIClient: resasApiClient)
            let resasUseCase = ResasUseCase(resasGateway: resasGateway)

            let geoDBApiClient = GeoDBAPIClient()
            let geoDBGateway = GeoDBGateway(geoDBAPIClient: geoDBApiClient)
            let geoDBUseCase = GeoDBUseCase(geoDBGateway: geoDBGateway)

            let wikiDataApiClient = WikiDataAPIClient()
            let wikiDataGateway = WikiDataGateway(wikiDataClient: wikiDataApiClient)
            let wikiDataUseCase = WikiDataUseCase(wikiDataGateway: wikiDataGateway)

            let database = RealmRepository()
            let databaseGataway = DataBaseGateway(database: database)
            let searchResultUseCase = SearchResultUseCase(gateway: databaseGataway)

            let viewModel = SearchLoadingViewModel(
                view: loadingVC,
                router: self,
                searchCondition: conditionData,
                resasUseCase: resasUseCase,
                geoDBUseCase: geoDBUseCase,
                wikiDataUseCase: wikiDataUseCase,
                searchResultUseCase: searchResultUseCase
            )
            loadingVC.inject(viewModel: viewModel)
            navigationController.pushViewController(loadingVC, animated: true)

        case let .searchResult(prefecture: prefecture, cityName: cityName):
            // TODO:
            break

        case .back:
            navigationController.popViewController(animated: true)
        }
    }
}
