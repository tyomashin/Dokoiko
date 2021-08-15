//
//  RecommendListViewModelTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/07/26.
//

@testable import Dokoiko
import RxCocoa
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class RecommendListViewModelTests: XCTestCase {
    var view: RecommendListVCProtocolMock!
    var router: RecommendListRouterProtocolMock!
    var searchResultEntity: SearchResultEntity!
    var viewModel: RecommendListViewModel!
    var spotSearchUseCase: SpotSearchUseCaseProtocolMock!
    var locationGateway: LocationGatewayProtocolMock!

    var scheguler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        view = RecommendListVCProtocolMock()
        router = RecommendListRouterProtocolMock()
        searchResultEntity = SearchResultEntity(id: "", prefCode: 0, prefName: "", cityName: "", cityCode: nil, lat: nil, lng: nil, date: nil)
        spotSearchUseCase = SpotSearchUseCaseProtocolMock()
        locationGateway = LocationGatewayProtocolMock()

        scheguler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        // モックにダミーデータを入れておく
        Given(view, .currentPage(getter: .empty()))
        Given(view, .tapCloseButton(getter: .empty()))
        Given(view, .tapSpot(getter: .empty()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        router = nil
        viewModel = nil
        spotSearchUseCase = nil
        locationGateway = nil
        disposeBag = nil
        scheguler = nil
    }

    /// 選択カテゴリ切り替えテスト
    func testSelectedCategoryInfo() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // Viewのカテゴリ選択イベント
        var tmpEvents: [RxTest.Recorded<Event<Int>>] = []
        var tmpTime: RxTest.TestTime = 10
        for i in 0 ..< SpotCategory.allCases.count {
            tmpEvents.append(RxTest.Recorded.next(tmpTime, i))
            tmpTime += 10
        }
        let selectCategoryEvents = scheguler.createColdObservable(tmpEvents).asDriver(onErrorJustReturn: -1)
        Given(view, .currentPage(getter: selectCategoryEvents))

        // インスタンス生成
        viewModel = RecommendListViewModel(
            view: view,
            router: router,
            searchResult: searchResultEntity,
            spotSearchUseCase: spotSearchUseCase,
            locationGateway: locationGateway
        )

        // カテゴリリストを受信するためのObserverを登録
        let categoryListEvents = scheguler.createObserver([SpotCategory].self)
        viewModel
            .categoryList
            .drive(categoryListEvents)
            .disposed(by: disposeBag)
        // 選択カテゴリ変化の通知を受信するためのObserverを登録
        let categoryInfoEvents = scheguler.createObserver(RecommendListViewModel.CategoryInfo.self)
        viewModel
            .categoryInfo
            .drive(categoryInfoEvents)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // カテゴリリストが正しく配信されているか
        XCTAssertEqual(categoryListEvents.events.count, 1)
        let resultCategoryListElement = categoryListEvents.events[0].value.element
        XCTAssertEqual(resultCategoryListElement!.count, SpotCategory.allCases.count)

        // カテゴリ変化イベントが配信されているかどうか
        // memo: イベント数 + 初期カテゴリのイベント
        XCTAssertEqual(categoryInfoEvents.events.count, tmpEvents.count + 1)
        // 想定のカテゴリが選択されているかどうか
        XCTAssertEqual(categoryInfoEvents.events[1].value.element!.selectedIndex, 0)
        XCTAssertEqual(categoryInfoEvents.events[2].value.element!.selectedIndex, 1)
        XCTAssertEqual(categoryInfoEvents.events[3].value.element!.selectedIndex, 2)
        XCTAssertEqual(categoryInfoEvents.events[4].value.element!.selectedIndex, 3)
        categoryInfoEvents.events.forEach { event in
            XCTAssertEqual(event.value.element!.categoryList.count, SpotCategory.allCases.count)
        }
    }

    // スポット一覧の更新についてのテスト
    func testUpdateSpotList() throws {
        // Viewのカテゴリ選択イベント
        let selectCategoryEvents = scheguler.createColdObservable([.next(10, 0)]).asDriver(onErrorJustReturn: 0)
        Given(view, .currentPage(getter: selectCategoryEvents))

        // 検索対象の都市情報
        searchResultEntity = SearchResultEntity(
            id: "70EBD334-29F5-43B5-92E0-A55D8E8840ED",
            prefCode: 28,
            prefName: "兵庫県",
            cityName: "兵庫区",
            cityCode: nil,
            lat: 34.675833333,
            lng: 135.166666666,
            date: Date()
        )

        // 位置情報
        Given(locationGateway, .getCurrentLocation(willReturn: Observable.of((0, 0))))
        var spotEntity = RecommendSpotEntity(
            name: "sample",
            lat: 0,
            lng: 0,
            distanceKM: nil,
            genre: ["category1"],
            address: nil,
            tel: nil,
            imageUrl: nil,
            coupons: nil
        )
        // ユースケースが返すスポットリストを登録しておく
        let spotSingle = Single<ApiResponseEntity<[RecommendSpotEntity]>>.create { single in
            single(.success(.success(response: [spotEntity])))
            return Disposables.create()
        }
        spotSearchUseCase.given(.getSpot(lat: 34.675833333, lng: 135.166666666, startIndex: 1, category: .any, willReturn: spotSingle))

        // インスタンス生成
        viewModel = RecommendListViewModel(
            view: view,
            router: router,
            searchResult: searchResultEntity,
            spotSearchUseCase: spotSearchUseCase,
            locationGateway: locationGateway
        )

        // スポットリストを受信するためのObserverを登録
        let spotDataListEvents = scheguler.createObserver([RecommendListViewModelProtocol.SpotEntityData].self)
        viewModel
            .spotEntityData
            .drive(spotDataListEvents)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // スポットリストが正しく配信されているか
        let event = spotDataListEvents.events.last!
        XCTAssertEqual(event.value.element?.first?.category, SpotCategory.restaurant)
        XCTAssertEqual(event.value.element?.first?.spotList.count, 1)
        // 距離を計算しておく
        let distance = LocationPointEntity.getPointDistance(location: (spotEntity.lat!, spotEntity.lng!), baseLocation: (0, 0))
        spotEntity.distanceKM = distance / 1000
        XCTAssertEqual(event.value.element?.first?.spotList[0], spotEntity)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
