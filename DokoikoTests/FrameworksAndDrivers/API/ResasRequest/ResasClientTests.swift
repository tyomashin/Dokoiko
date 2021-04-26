//
//  ResasClientTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/25.
//

@testable import Dokoiko
import OHHTTPStubs
import RxBlocking
import RxSwift
import RxTest
import XCTest

class ResasClientTests: XCTestCase {
    var resasClient: ResasAPIClientProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        resasClient = ResasAPIClient()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        resasClient = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    /// ResasAPIで市区町村を取得するテスト
    func testGetMunicipalities() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // ネットワーク通信スタブ：正常系
        stub(condition: isHost("opendata.resas-portal.go.jp")) { _ in
            let stubPath = OHPathForFile("resasMunicipalityPrefCode27.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }

        var result = try! resasClient.getMunicipalities(prefCode: "27").toBlocking(timeout: 5000).single()
        switch result {
        case let .success(response: response):
            XCTAssertEqual(response.result?.filter { $0.cityName == "大阪市" && $0.bigCityFlag == "2" }.count, 1)
        case .error(error: _):
            XCTFail()
        }

        // ステータスエラー
        stub(condition: isHost("opendata.resas-portal.go.jp")) { _ in
            let stubPath = OHPathForFile("resasMunicipalityPrefCode27.json", type(of: self))
            return fixture(filePath: stubPath!, status: 400, headers: ["Content-Type": "application/json"])
        }
        result = try! resasClient.getMunicipalities(prefCode: "27").toBlocking(timeout: 1000).single()
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
        stub(condition: isHost("opendata.resas-portal.go.jp")) { _ in
            let stubPath = OHPathForFile("empty.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }
        result = try! resasClient.getMunicipalities(prefCode: "27").toBlocking(timeout: 1000).single()
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
        let citiesRequest = ResasAPIRequest.cities(prefCode: "28")
        let url = resasClient.getDefaultUrlRequest(request: citiesRequest)
        guard let urlStr = url?.url?.absoluteString else {
            XCTFail()
            return
        }
        // クエリパラメータがURLに含まれているかテスト
        XCTAssertTrue(urlStr.contains("prefCode=28"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
