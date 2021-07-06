//
//  SearchConditionViewModelTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/06/07.
//

@testable import Dokoiko
import RxCocoa
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class SearchConditionViewModelTests: XCTestCase {
    var view: SearchConditionVCProtocolMock!
    var appDataGateway: AppDataGatewayProtocolMock!
    var locationGateway: LocationGatewayProtocolMock!
    var router: SearchConditionRouterProtocolMock!
    var viewModel: SearchConditionViewModel!
    var searchResultUseCase: SearchResultUseCaseProtocolMock!
    var scheguler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = SearchConditionVCProtocolMock()
        appDataGateway = AppDataGatewayProtocolMock()
        locationGateway = LocationGatewayProtocolMock()
        router = SearchConditionRouterProtocolMock()
        scheguler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        // memo: Single は scheduler から生成したObservableをもとに作れなかった（イベントが流れない）ので手動で作成
        let appData = Single<SearchConditionPrefectures?>.create { single in
            single(.success(nil))
            return Disposables.create()
        }
        // let locationAuth = Observable.just(LocationAuthEntity.available)
        // let locations = Observable<(lat: Double, lng: Double)>.just((0, 0))
        Given(appDataGateway, .searchConditionPrefectures(getter: appData))
        Given(locationGateway, .getLocationAuth(willReturn: .empty()))
        Given(locationGateway, .getCurrentLocation(willReturn: .empty()))
        Given(view, .tapBackButton(getter: .empty()))
        Given(view, .tapSearchButton(getter: .empty()))
        Given(view, .selectedRadius(getter: .empty()))
        Given(view, .selectedLocation(getter: .empty()))
        Given(view, .selectedSearchCondition(getter: .empty()))
        Given(view, .areaSelectedIndex(getter: .empty()))
        Given(view, .prefectureSelectedIndex(getter: .empty()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        appDataGateway = nil
        locationGateway = nil
        router = nil
        scheguler = nil
        disposeBag = nil
    }

    /// 検索ボタン周りのテスト
    func testSearchButton() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // 検索条件タップイベント
        let selectConditionEvents = scheguler
            .createColdObservable([.next(10, 0), .next(20, 1)])
            .asDriver(onErrorJustReturn: 0)
        // Viewモックが返すObservableに指定する
        Given(view, .selectedSearchCondition(getter: selectConditionEvents))

        // 検索ボタンタップイベント
        let tapSearchEvents = scheguler
            .createColdObservable([.next(30, ())])
            .asSignal(onErrorJustReturn: ())
        Given(view, .tapSearchButton(getter: tapSearchEvents))

        // インスタンス生成
        viewModel = SearchConditionViewModel(view: view,
                                             router: router,
                                             appDataGateway: appDataGateway,
                                             locationGateway: locationGateway)

        // テスト結果受取用Observerを登録：検索ボタン活性化フラグ
        let isEnableEvent = scheguler.createObserver(Bool.self)
        viewModel
            .searchPermission
            .drive(isEnableEvent)
            .disposed(by: disposeBag)

        // テスト結果受取用Observerを登録：検索条件変更イベント
        let conditionEvent = scheguler.createObserver(SearchConditionType.self)
        viewModel
            .selectedSearchConditionType
            .drive(conditionEvent)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // 検索ボタン活性化テスト
        XCTAssertEqual(isEnableEvent.events[0].value.element, false)
        XCTAssertEqual(isEnableEvent.events[1].value.element, true)
        XCTAssertEqual(isEnableEvent.events[2].value.element, true)

        // 検索条件が選択された時にイベントが発火しているかどうかのテスト
        XCTAssertEqual(conditionEvent.events[0].value.element, .prefectures)
        XCTAssertEqual(conditionEvent.events[1].value.element, .currentLocation)

        // 検索ボタンタップ後の画面遷移処理が呼ばれているかどうかのテスト
        Verify(router, .navigate(to: .any))
    }

    /// 「都道府県から検索」のテスト
    func testPrefecturesSearch() throws {
        // 都道府県選択時のイベント
        let firstPrefecture = RegionalBlockType.Kanto.prefectures[0]
        let selectPrefecturesEvents = scheguler
            .createColdObservable([.next(10, 0)])
            .asDriver(onErrorJustReturn: 0)
        // Viewモックが返すObservableに指定する
        Given(view, .prefectureSelectedIndex(getter: selectPrefecturesEvents))

        // エリア選択時のイベント
        let secondRegion = RegionalBlockType.allCases[0]
        let selectAreaEvents = scheguler
            .createColdObservable([.next(20, 0)])
            .asDriver(onErrorJustReturn: 0)
        // Viewモックが返すObservableに指定する
        Given(view, .areaSelectedIndex(getter: selectAreaEvents))

        viewModel = SearchConditionViewModel(view: view,
                                             router: router,
                                             appDataGateway: appDataGateway,
                                             locationGateway: locationGateway)

        // テスト結果受取用Observerを登録：検索条件オブジェクト変更イベント
        let conditionEvent = scheguler.createObserver(SearchConditionPrefectures.self)
        viewModel
            .searchConditionPrefectures
            .drive(conditionEvent)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // 3回検索条件オブジェクトが流れてくることを確認
        // （time == 0 ... 初期値, 10, 20 ... 上で指定したセレクトイベント発火時に流れる）
        XCTAssertEqual(conditionEvent.events.count, 3)
        // 初期値の確認
        let initialEvent = conditionEvent.events[0]
        let initialElement = initialEvent.value.element!
        XCTAssertEqual(initialEvent.time, 0)
        var region = RegionalBlockType.allCases[initialElement.selectedRegionBlockIndex]
        var prefecture = initialElement.prefecturesList[initialElement.selectedPrefectureIndex]
        // 関東エリア、東京都が選択されていることをテスト
        XCTAssertEqual(region, .Kanto)
        XCTAssertEqual(prefecture, .Tokyo)

        // 都道府県選択時のイベント (time == 10)
        let firstEvent = conditionEvent.events[1]
        let firstElement = firstEvent.value.element!
        XCTAssertEqual(firstEvent.time, 10)
        prefecture = firstElement.prefecturesList[firstElement.selectedPrefectureIndex]
        // 都道府県のみ変更した場合のテスト
        XCTAssertEqual(region, .Kanto)
        XCTAssertEqual(prefecture, firstPrefecture)

        // エリア選択時のイベント（time == 20）
        let secondEvent = conditionEvent.events[2]
        let secondElement = secondEvent.value.element!
        XCTAssertEqual(secondEvent.time, 20)
        region = RegionalBlockType.allCases[secondElement.selectedRegionBlockIndex]
        prefecture = region.prefectures[0]
        // エリアを変更した場合のテスト
        // 北海道エリアに変更するように指定している。エリア変更時は都道府県リストのindex == 0になる
        XCTAssertEqual(region, secondRegion)
        XCTAssertEqual(prefecture, secondRegion.prefectures[0])
    }

    /// 「現在地の近くから検索」のテスト
    func testCurrentLocationSearch() throws {
        /* LocationGateway が返す Observable の定義 */
        // 位置情報利用許可イベント
        let currentLocationEvents: Observable<LocationAuthEntity> = scheguler
            .createColdObservable([.next(0, LocationAuthEntity.available)])
            .asObservable()
        // LocationGatewayモックが返すObservableに指定する
        Given(locationGateway, .getLocationAuth(willReturn: currentLocationEvents))

        // 現在地更新イベント
        let locationUpdateEvents: Observable<(lat: Double, lng: Double)> = scheguler
            .createColdObservable([.next(10, (90, 90)), .next(20, (180, 180))])
            .asObservable()
        // LocationGatewayモックが返すObservableに指定する
        Given(locationGateway, .getCurrentLocation(willReturn: locationUpdateEvents))

        /* Viewが返すObservableの定義 */
        // 地点が選択された時のイベント
        let selectPointEvents: Driver<(lat: Double, lng: Double)> = scheguler
            .createColdObservable([.next(30, (30, 130)), .next(40, (40, 140))])
            .asDriver(onErrorJustReturn: (0, 0))
        // Viewモックが返すObservableに指定する
        Given(view, .selectedLocation(getter: selectPointEvents))

        // 半径が更新された時のイベント
        let selectRadiusEvents: Driver<Float> = scheguler
            .createColdObservable([.next(50, 40)])
            .asDriver(onErrorJustReturn: 0)
        // Viewモックが返すObservableに指定する
        Given(view, .selectedRadius(getter: selectRadiusEvents))

        viewModel = SearchConditionViewModel(view: view,
                                             router: router,
                                             appDataGateway: appDataGateway,
                                             locationGateway: locationGateway)

        // テスト結果受取用Observerを登録：現在地変更イベント
        let locationEvent = scheguler.createObserver((lat: Double, lng: Double).self)
        viewModel
            .currentLocation
            .drive(locationEvent)
            .disposed(by: disposeBag)

        // テスト結果受取用Observerを登録：検索条件オブジェクト変更イベント
        let conditionEvent = scheguler.createObserver(SearchConditionCurrentLocation.self)
        viewModel
            .searchConditionCurrentLocation
            .drive(conditionEvent)
            .disposed(by: disposeBag)

        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        // 更新された現在地を受け取れているかのテスト
        let firstLocationEvent = locationEvent.events.first { $0.time == 10 }!.value.element
        XCTAssertEqual(firstLocationEvent!.lat, 90)
        XCTAssertEqual(firstLocationEvent!.lng, 90)
        let secondLocationEvent = locationEvent.events.first { $0.time == 20 }!.value.element
        XCTAssertEqual(secondLocationEvent!.lat, 180)
        XCTAssertEqual(secondLocationEvent!.lng, 180)

        // 検索条件オブジェクトの初期値が正しいかのテスト
        // memo: 最初に現在地（GPS）を取得した際にイベントが発行され、以降は発行されないため最後の要素を取り出す
        let searchConditionEvent = conditionEvent.events.last!.value.element
        // memo: 最初の現在地(GPS)の緯度経度が格納されているかを確認している
        XCTAssertEqual(searchConditionEvent!.lat, 90)
        XCTAssertEqual(searchConditionEvent!.lng, 90)

        // TODO: ViewModel側に、確定検索条件データのRelayを追加する
        // TODO: 検索ボタンがタップされた時に、上のRelayを更新する（テスト用）
        // TODO: 以下でその確認テストを追加
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
