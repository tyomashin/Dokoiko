//
//  LocalSearchClientTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/07/10.
//

@testable import Dokoiko
import OHHTTPStubs
import RxBlocking
import RxSwift
import RxTest
import XCTest

class LocalSearchClientTests: XCTestCase {
    var localSearchClient: LocalSearchAPIClient!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        localSearchClient = LocalSearchAPIClient()
        disposeBag = DisposeBag()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        localSearchClient = nil
        disposeBag = nil
        scheduler = nil
        testScheduler = nil
    }

    /// スポット取得テスト
    func testLocalSearchRequest() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // ネットワーク通信スタブ：正常系
        stub(condition: isHost("map.yahooapis.jp")) { _ in
            let stubPath = OHPathForFile("localSearch.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }
        var result = try! localSearchClient.getSpot(cityCode: "", startIndex: 1, category: .restaurant).toBlocking(timeout: 1000).single()
        switch result {
        case let .success(response: response):
            // 最低限、全件のスポットが取得できているか確認
            XCTAssertTrue(response.feature?.count == 100)
            XCTAssertTrue(response.resultInfo != nil)
        case .error(error: _):
            XCTFail()
        }

        // ステータスエラー
        stub(condition: isHost("map.yahooapis.jp")) { _ in
            let stubPath = OHPathForFile("localSearch.json", type(of: self))
            return fixture(filePath: stubPath!, status: 400, headers: ["Content-Type": "application/json"])
        }
        result = try! localSearchClient.getSpot(lat: 0, lng: 0, startIndex: 1, category: .restaurant).toBlocking(timeout: 1000).single()
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
        stub(condition: isHost("map.yahooapis.jp")) { _ in
            let stubPath = OHPathForFile("empty.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }
        result = try! localSearchClient.getSpot(cityCode: "", startIndex: 1, category: .restaurant).toBlocking(timeout: 1000).single()
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
        var spotRequest = LocalSearchAPIRequest.spotWithCity(cityCode: "00000", startIndex: "100", gc: "01")
        var url = localSearchClient.getDefaultUrlRequest(request: spotRequest)
        guard let urlStr = url?.url?.absoluteString else {
            XCTFail()
            return
        }
        // クエリパラメータがURLに含まれているかテスト
        XCTAssertTrue(urlStr.contains("ac=00000"))
        XCTAssertTrue(urlStr.contains("start=100"))
        XCTAssertTrue(urlStr.contains("gc=01"))

        spotRequest = .spotWithLocation(lat: "35.12345", lng: "135.567890", startIndex: "1", gc: "02")
        url = localSearchClient.getDefaultUrlRequest(request: spotRequest)
        guard let urlWithLocationStr = url?.url?.absoluteString else {
            XCTFail()
            return
        }
        // クエリパラメータがURLに含まれているかテスト
        XCTAssertTrue(urlWithLocationStr.contains("lat=35.12345"))
        XCTAssertTrue(urlWithLocationStr.contains("lon=135.567890"))
        XCTAssertTrue(urlWithLocationStr.contains("start=1"))
        XCTAssertTrue(urlWithLocationStr.contains("gc=02"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
