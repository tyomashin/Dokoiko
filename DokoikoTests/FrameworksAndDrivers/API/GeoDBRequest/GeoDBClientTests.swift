//
//  GeoDBClientTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/26.
//

@testable import Dokoiko
import OHHTTPStubs
import RxBlocking
import RxSwift
import RxTest
import XCTest

class GeoDBClientTests: XCTestCase {
    var geoDBClient: GeoDBAPIClientProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        geoDBClient = GeoDBAPIClient()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        geoDBClient = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    /// GeoDBCitiesで市区情報を取得する
    func testGetGeoDBCities() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // ネットワーク通信スタブ：正常系
        stub(condition: isHost("wft-geo-db.p.rapidapi.com")) { _ in
            let stubPath = OHPathForFile("geoDBCities.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }
        var result = try! geoDBClient.getCitiesInArea(location: "", radiusKM: "").toBlocking(timeout: 1000).single()
        switch result {
        case let .success(response: response):
            XCTAssertTrue(response.data?.count != 0)
        case .error(error: _):
            XCTFail()
        }

        // ステータスエラー
        stub(condition: isHost("wft-geo-db.p.rapidapi.com")) { _ in
            let stubPath = OHPathForFile("geoDBCities.json", type(of: self))
            return fixture(filePath: stubPath!, status: 400, headers: ["Content-Type": "application/json"])
        }
        result = try! geoDBClient.getCitiesInArea(location: "", radiusKM: "").toBlocking(timeout: 1000).single()
        switch result {
        case .success(response: _):
            XCTFail()
        case let .error(error: error):
            switch error {
            case let .statusCodeError(statusCode: statusCode):
                XCTAssertEqual(statusCode, .someError)
            default:
                XCTFail()
            }
        }

        // データエンプティ
        stub(condition: isHost("wft-geo-db.p.rapidapi.com")) { _ in
            let stubPath = OHPathForFile("empty.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }
        result = try! geoDBClient.getCitiesInArea(location: "", radiusKM: "").toBlocking(timeout: 1000).single()
        switch result {
        case .success(response: _):
            XCTFail()
        case let .error(error: error):
            switch error {
            case .dataEmptyError:
                XCTAssertTrue(true)
            default:
                XCTFail()
            }
        }
    }

    /// リクエストのテスト
    func testRequest() throws {
        let citiesRequest = GeoDBAPIRequest.cities(location: "+30.000+130.000", radiusKM: "5")
        let url = geoDBClient.getDefaultUrlRequest(request: citiesRequest)
        guard let urlStr = url?.url?.absoluteString else {
            XCTFail()
            return
        }
        // クエリパラメータがURLに含まれているかテスト
        XCTAssertTrue(urlStr.contains("location=%2B30.000%2B130.000"))
        XCTAssertTrue(urlStr.contains("radius=5"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
