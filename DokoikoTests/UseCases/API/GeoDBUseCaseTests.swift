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
    var useCase: GeoDBUseCaseProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        useCase = GeoDBUseCase(geoDBGateway: GeoDBGatewayMock())
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        useCase = nil
        scheduler = nil
        testScheduler = nil
    }

    func testGet() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let result = try! useCase.getCitiesInArea(lat: 30.000, lng: 135.000, radiusKM: 10.555).toBlocking(timeout: 5000).single()
        switch result {
        case let .success(response: response):
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
