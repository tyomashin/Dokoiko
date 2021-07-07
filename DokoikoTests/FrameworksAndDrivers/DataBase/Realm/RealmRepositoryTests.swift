//
//  RealmRepositoryTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/29.
//

@testable import Dokoiko
import RxBlocking
import RxSwift
import RxTest
import XCTest

class RealmRepositoryTests: XCTestCase {
    var repository: RealmRepository!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        repository = RealmRepository()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        repository = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    /// 市区の検索結果の保存処理と緯度経度変更処理のテスト
    func testSaveCitySearchResult() throws {
        // 保存処理
        var result = try! repository.saveCitySearchResult(prefCode: 1, cityName: "京都市", cityCode: "00000", lat: nil, lng: nil)
            .toBlocking(timeout: 5000).single()
        switch result {
        case let .success(city):
            XCTAssertEqual(city.prefCode, 1)
            XCTAssertEqual(city.cityName, "京都市")
            XCTAssertEqual(city.cityCode, "00000")
        case .failure:
            XCTFail()
        }

        var tmpID = ""
        result = try! repository.saveCitySearchResult(prefCode: 5, cityName: "長野市", cityCode: nil, lat: 30.123, lng: 135.56789)
            .toBlocking(timeout: 5000).single()
        switch result {
        case let .success(city):
            XCTAssertEqual(city.prefCode, 5)
            XCTAssertEqual(city.cityName, "長野市")
            XCTAssertEqual(city.lat.value, 30.123)
            XCTAssertEqual(city.lng.value, 135.56789)
            tmpID = city.id
        case .failure:
            XCTFail()
        }

        /// 緯度経度を変更処理のテスト
        let setResult = try! repository.setCityLocation(id: tmpID, lat: 35.567, lng: 135.222).toBlocking(timeout: 5000).single()
        switch setResult {
        case let .success(city):
            XCTAssertEqual(city.id, tmpID)
            XCTAssertEqual(city.lat.value, 35.567)
            XCTAssertEqual(city.lng.value, 135.222)
        case .failure:
            XCTFail()
        }
    }

    /// 市区の検索結果一覧を取得
    func testGetCitySearchResult() throws {
        // 前準備
        _ = try! repository.saveCitySearchResult(prefCode: 1, cityName: "京都市", cityCode: "00000", lat: nil, lng: nil).toBlocking(timeout: 5000).single()

        let result = try! repository.getCitySearchResult().toBlocking(timeout: 5000).single()
        switch result {
        case let .success(cityList):
            XCTAssertTrue(cityList.count != 0)
        case .failure:
            XCTFail()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
