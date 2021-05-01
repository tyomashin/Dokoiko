//
//  GeoDBUseCaseTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/28.
//

@testable import Dokoiko
import RxBlocking
import RxSwift
import RxTest
import XCTest

class GeoDBUseCaseTests: XCTestCase {
    var geoDBGatewayMock: GeoDBGatewayProtocolMock!
    var useCase: GeoDBUseCaseProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        geoDBGatewayMock = GeoDBGatewayProtocolMock()
        useCase = GeoDBUseCase(geoDBGateway: geoDBGatewayMock)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        geoDBGatewayMock = nil
        useCase = nil
        scheduler = nil
        testScheduler = nil
    }

    /// エリア内の市区情報を受け取るメソッドのテスト
    /// memo: APIクライアントのテストは別で行っているのでここの試験は簡易的に行っている
    func testGet() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // モックのメソッドが返す値を定義
        let single = Single<ApiResponseEntity<GeoDBCitiesEntity>>.create { single in
            // ローカルのJsonを読みこむ
            var result: ApiResponseEntity<GeoDBCitiesEntity>
            if let object: GeoDBCitiesEntity = JSONDecoder().decodeFromJsonFile(bundle: Bundle(for: type(of: self)),
                                                                                fileName: "geoDBCities")
            {
                result = .success(response: object)
            } else {
                result = .error(error: .dataEmptyError)
            }
            single(.success(result))
            return Disposables.create()
        }
        // モックが返すデータを指定
        geoDBGatewayMock.given(.getCitiesInArea(lat: 0, lng: 0, radiusKM: 0, willReturn: single))

        let result = try! useCase.getCitiesInArea(lat: 0, lng: 0, radiusKM: 0).toBlocking(timeout: 5000).single()
        switch result {
        case let .success(response: response):
            // レスポンスが空でないかだけ確認
            XCTAssertTrue(response.data?.count != 0)
        case .error(error: _):
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
