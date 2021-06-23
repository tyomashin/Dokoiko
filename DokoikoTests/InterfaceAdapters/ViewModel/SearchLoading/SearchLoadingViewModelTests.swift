//
//  SearchLoadingViewModelTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/06/22.
//

@testable import Dokoiko
import RxCocoa
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class SearchLoadingViewModelTests: XCTestCase {
    var view: SearchLoadingVCProtocolMock!
    var viewModel: SearchLoadingViewModel!
    var resasUseCase: ResasUseCaseProtocolMock!
    var geoDBUseCase: GeoDBUseCaseProtocolMock!
    var wikiDataUseCase: WikiDataUseCaseProtocolMock!
    var databaseUseCase: SearchResultUseCaseProtocolMock!
    var router: SearchLoadingRouterProtocolMock!
    var scheguler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = SearchLoadingVCProtocolMock()
        resasUseCase = ResasUseCaseProtocolMock()
        geoDBUseCase = GeoDBUseCaseProtocolMock()
        wikiDataUseCase = WikiDataUseCaseProtocolMock()
        databaseUseCase = SearchResultUseCaseProtocolMock()
        router = SearchLoadingRouterProtocolMock()
        scheguler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        // モックが返す適当な値を設定
        Given(view, .completionAnmation(getter: .empty()))

        // 各ユースケースが返す適当な値を指定
        let resasSingle = Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>.create { single in
            single(.success(.success(response: ResasMunicipalityResponseEntity(result: nil))))
            return Disposables.create()
        }
        Given(resasUseCase, .getCitiesInPrefecture(prefCode: "", willReturn: resasSingle))
        let geoDBSingle = Single<ApiResponseEntity<GeoDBCitiesEntity>>.create { _ in
            Disposables.create()
        }
        Given(geoDBUseCase, .getCitiesInArea(lat: 0.0, lng: 0.0, radiusKM: 5, willReturn: geoDBSingle))
        let wikiDataSingle = Single<ApiResponseEntity<WikiDataResponseEntity>>.create { _ in
            Disposables.create()
        }
        Given(wikiDataUseCase, .getWikiData(wikiCode: "", willReturn: wikiDataSingle))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        resasUseCase = nil
        geoDBUseCase = nil
        wikiDataUseCase = nil
        router = nil
        scheguler = nil
        disposeBag = nil
    }

    /// ローディング完了後に画面遷移メソッドがコールされているかのテスト
    func testTransitionSearchResult() throws {
        /* 前準備 */
        // Viewが発行するアニメーション完了イベントの定義
        let completionAnimationRelay = BehaviorRelay<Bool?>.init(value: nil)
        let completionAnimation = completionAnimationRelay.compactMap { $0 }.asSignal(onErrorJustReturn: false)
        // Viewのモックが返すイベントに指定する
        Given(view, .completionAnmation(getter: completionAnimation))

        // 適当な検索条件オブジェクトを生成
        let prefectures = SearchConditionPrefectures(
            regionBlockList: RegionalBlockType.allCases,
            selectedRegionBlockIndex: 3,
            prefecturesList: RegionalBlockType.allCases[3].prefectures,
            selectedPrefectureIndex: 0
        )
        let conditionEntity = SearchConditionDataEntity.prefectures(condition: prefectures)
        // ユースケースが返す適当な値を指定
        let prefCode = prefectures.prefecturesList[prefectures.selectedPrefectureIndex].prefCode
        let resasSingle = Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>.create { single in
            let results: [ResasMunicipalityDetail] = [ResasMunicipalityDetail(prefCode: prefCode, cityCode: nil, cityName: "test", bigCityFlag: "")]
            single(.success(.success(response: ResasMunicipalityResponseEntity(result: results))))
            return Disposables.create()
        }
        Given(resasUseCase, .getCitiesInPrefecture(prefCode: Parameter<String>(stringLiteral: "\(prefCode)"), willReturn: resasSingle))

        // ViewModelのインスタンス生成
        viewModel = SearchLoadingViewModel(
            view: view,
            router: router,
            searchCondition: conditionEntity,
            resasUseCase: resasUseCase,
            geoDBUseCase: geoDBUseCase,
            wikiDataUseCase: wikiDataUseCase,
            searchResultUseCase: databaseUseCase
        )

        viewModel.loadedViews()

        /* テスト開始 */
        // 「都道府県から検索」時は最低１秒間のAPI実行時間が発生するため少し待機している
        let expectation = XCTestExpectation(description: "view hidden")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            /* 評価 */
            // Viewの完了イベントを発火させる
            completionAnimationRelay.accept(true)
            // 1. 画面遷移ロジックが呼ばれているかどうか確認
            Verify(self.router, .navigate(to: .any))
            expectation.fulfill()
        }
        XCTWaiter().wait(for: [expectation], timeout: 10)
    }

    /// 「都道府県から検索」時のローディング状態テスト：正常系
    func testPrefectureSearchLoading() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        /* 前準備 */
        // 検索条件オブジェクトを生成
        let prefectures = SearchConditionPrefectures(
            regionBlockList: RegionalBlockType.allCases,
            selectedRegionBlockIndex: 3,
            prefecturesList: RegionalBlockType.allCases[3].prefectures,
            selectedPrefectureIndex: 0
        )
        let conditionEntity = SearchConditionDataEntity.prefectures(condition: prefectures)
        // ユースケースが返す適当な値を指定
        let prefCode = prefectures.prefecturesList[prefectures.selectedPrefectureIndex].prefCode
        let resasSingle = Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>.create { single in
            let results: [ResasMunicipalityDetail] = [ResasMunicipalityDetail(prefCode: prefCode, cityCode: nil, cityName: "test", bigCityFlag: "")]
            single(.success(.success(response: ResasMunicipalityResponseEntity(result: results))))
            return Disposables.create()
        }
        Given(resasUseCase, .getCitiesInPrefecture(prefCode: Parameter<String>(stringLiteral: "\(prefCode)"), willReturn: resasSingle))

        // ViewModelのインスタンス生成
        viewModel = SearchLoadingViewModel(
            view: view,
            router: router,
            searchCondition: conditionEntity,
            resasUseCase: resasUseCase,
            geoDBUseCase: geoDBUseCase,
            wikiDataUseCase: wikiDataUseCase,
            searchResultUseCase: databaseUseCase
        )

        // テスト結果受取用Observerを登録：検索条件オブジェクト変更イベント
        let loadingEvent = scheguler.createObserver(LoadingState.self)
        viewModel
            .loadingState
            .drive(loadingEvent)
            .disposed(by: disposeBag)

        /* 試験開始 */
        viewModel.loadedViews()
        // 「都道府県から検索」時は最低１秒間のAPI実行時間が発生するため少し待機している
        let expectation = XCTestExpectation(description: "view hidden")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        XCTWaiter().wait(for: [expectation], timeout: 10)

        /* 評価 */
        let events = loadingEvent.events
        // ローディング状態は、idle -> loading -> completion と変わることを確認
        XCTAssertEqual(events.count, 3)

        switch events[0].value.element! {
        case .idle: break
        default: XCTFail()
        }

        switch events[1].value.element! {
        case .loading: break
        default: XCTFail()
        }

        switch events[2].value.element! {
        case .completion: break
        default: XCTFail()
        }

        // 検索結果が保存されているかどうか確認
        Verify(databaseUseCase, 1, .saveCitySearchResult(prefCode: Parameter<Int>(integerLiteral: prefCode), cityName: "test"))
    }

    /// 「都道府県から検索」時のローディング状態テスト：異常系
    func testPrefectureSearchLoadingAbnormal() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        /* 前準備 */
        // 検索条件オブジェクトを生成
        let prefectures = SearchConditionPrefectures(
            regionBlockList: RegionalBlockType.allCases,
            selectedRegionBlockIndex: 3,
            prefecturesList: RegionalBlockType.allCases[3].prefectures,
            selectedPrefectureIndex: 0
        )
        let conditionEntity = SearchConditionDataEntity.prefectures(condition: prefectures)
        // ユースケースが返す値として空のリストを指定
        let prefCode = prefectures.prefecturesList[prefectures.selectedPrefectureIndex].prefCode
        let resasSingle = Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>.create { single in
            single(.success(.success(response: ResasMunicipalityResponseEntity(result: nil))))
            return Disposables.create()
        }
        Given(resasUseCase, .getCitiesInPrefecture(prefCode: Parameter<String>(stringLiteral: "\(prefCode)"), willReturn: resasSingle))

        // ViewModelのインスタンス生成
        viewModel = SearchLoadingViewModel(
            view: view,
            router: router,
            searchCondition: conditionEntity,
            resasUseCase: resasUseCase,
            geoDBUseCase: geoDBUseCase,
            wikiDataUseCase: wikiDataUseCase,
            searchResultUseCase: databaseUseCase
        )

        // テスト結果受取用Observerを登録：検索条件オブジェクト変更イベント
        let loadingEvent = scheguler.createObserver(LoadingState.self)
        viewModel
            .loadingState
            .drive(loadingEvent)
            .disposed(by: disposeBag)

        /* 試験開始 */
        viewModel.loadedViews()
        // 「都道府県から検索」時は最低１秒間のAPI実行時間が発生するため少し待機している
        let expectation = XCTestExpectation(description: "view hidden")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        XCTWaiter().wait(for: [expectation], timeout: 10)

        /* 評価 */
        let events = loadingEvent.events
        // ローディング状態は、idle -> loading -> error と変わることを確認
        XCTAssertEqual(events.count, 3)

        switch events[0].value.element! {
        case .idle: break
        default: XCTFail()
        }

        switch events[1].value.element! {
        case .loading: break
        default: XCTFail()
        }

        switch events[2].value.element! {
        case .error(message: _): break
        default: XCTFail()
        }

        // 検索結果が保存されていないことを確認
        Verify(databaseUseCase, 0, .saveCitySearchResult(prefCode: Parameter<Int>(integerLiteral: prefCode), cityName: "test"))
    }

    /// 「現在地から検索」時のローディングテスト：正常系
    func testLocationSearchLoading() throws {
        /* 前準備 */
        // 検索条件オブジェクトを生成
        let currentLocation = SearchConditionCurrentLocation(lat: 35, lng: 135, radius: 5, maxRadius: 10, minRadius: 50)
        let conditionEntity = SearchConditionDataEntity.currentLocation(condition: currentLocation)

        // ユースケースが返す値を定義
        let prefCode = 1
        let geoDBSingle = Single<ApiResponseEntity<GeoDBCitiesEntity>>.create { single in
            let result = [GeoDBCityData(id: 0, wikiDataId: "Qxx", name: "", regionCode: "\(prefCode)", latitude: nil, longitude: nil, population: nil, distance: nil)]
            single(.success(.success(response: GeoDBCitiesEntity(data: result))))
            return Disposables.create()
        }
        Given(geoDBUseCase, .getCitiesInArea(lat: 35, lng: 135, radiusKM: 5, willReturn: geoDBSingle))

        let wikiDataSingle = Single<ApiResponseEntity<WikiDataResponseEntity>>.create { single in
            let result = ["Qxx": WikiDataDetails(labels: WikiDataJapanLabel(ja: WikiDataLabelDetail(language: nil, value: "test")))]
            single(.success(.success(response: WikiDataResponseEntity(entities: result))))
            return Disposables.create()
        }
        Given(wikiDataUseCase, .getWikiData(wikiCode: "Qxx", willReturn: wikiDataSingle))

        // ViewModelのインスタンス生成
        viewModel = SearchLoadingViewModel(
            view: view,
            router: router,
            searchCondition: conditionEntity,
            resasUseCase: resasUseCase,
            geoDBUseCase: geoDBUseCase,
            wikiDataUseCase: wikiDataUseCase,
            searchResultUseCase: databaseUseCase
        )

        // テスト結果受取用Observerを登録：検索条件オブジェクト変更イベント
        let loadingEvent = scheguler.createObserver(LoadingState.self)
        viewModel
            .loadingState
            .drive(loadingEvent)
            .disposed(by: disposeBag)

        /* 試験開始 */
        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        let events = loadingEvent.events
        // ローディング状態は、idle -> loading -> completion と変わることを確認
        XCTAssertEqual(events.count, 3)

        switch events[0].value.element! {
        case .idle: break
        default: XCTFail()
        }

        switch events[1].value.element! {
        case .loading: break
        default: XCTFail()
        }

        switch events[2].value.element! {
        case .completion: break
        default: XCTFail()
        }

        // 検索結果が保存されているかどうか確認
        Verify(databaseUseCase, 1, .saveCitySearchResult(prefCode: Parameter<Int>(integerLiteral: prefCode), cityName: "test"))
    }

    /// 「現在地から検索」時のローディングテスト：異常系
    func testLocationSearchLoadingAbnormal() throws {
        /* 前準備 */
        // 検索条件オブジェクトを生成
        let currentLocation = SearchConditionCurrentLocation(lat: 35, lng: 135, radius: 5, maxRadius: 10, minRadius: 50)
        let conditionEntity = SearchConditionDataEntity.currentLocation(condition: currentLocation)

        // ユースケースが返す値を定義
        let geoDBSingle = Single<ApiResponseEntity<GeoDBCitiesEntity>>.create { single in
            // APIレスポンスでエラーを返す
            single(.success(.error(error: .dataEmptyError)))
            return Disposables.create()
        }
        Given(geoDBUseCase, .getCitiesInArea(lat: 35, lng: 135, radiusKM: 5, willReturn: geoDBSingle))

        let wikiDataSingle = Single<ApiResponseEntity<WikiDataResponseEntity>>.create { single in
            single(.success(.error(error: .dataEmptyError)))
            return Disposables.create()
        }
        Given(wikiDataUseCase, .getWikiData(wikiCode: "Qxx", willReturn: wikiDataSingle))

        // ViewModelのインスタンス生成
        viewModel = SearchLoadingViewModel(
            view: view,
            router: router,
            searchCondition: conditionEntity,
            resasUseCase: resasUseCase,
            geoDBUseCase: geoDBUseCase,
            wikiDataUseCase: wikiDataUseCase,
            searchResultUseCase: databaseUseCase
        )

        // テスト結果受取用Observerを登録：検索条件オブジェクト変更イベント
        let loadingEvent = scheguler.createObserver(LoadingState.self)
        viewModel
            .loadingState
            .drive(loadingEvent)
            .disposed(by: disposeBag)

        /* 試験開始 */
        viewModel.loadedViews()
        scheguler.start()

        /* 評価 */
        let events = loadingEvent.events
        // ローディング状態は、idle -> loading -> error と変わることを確認
        XCTAssertEqual(events.count, 3)

        switch events[0].value.element! {
        case .idle: break
        default: XCTFail()
        }

        switch events[1].value.element! {
        case .loading: break
        default: XCTFail()
        }

        switch events[2].value.element! {
        case .error(message: _): break
        default: XCTFail()
        }

        // 検索結果が保存されていないことを確認
        Verify(databaseUseCase, 0, .saveCitySearchResult(prefCode: Parameter<Int>(integerLiteral: 1), cityName: "test"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
