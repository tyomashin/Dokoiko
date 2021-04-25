//
//  ResasUseCaseTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/24.
//

@testable import Dokoiko
import RxBlocking
import RxSwift
import RxTest
import XCTest

class ResasUseCaseTests: XCTestCase {
    var useCase: ResasUseCaseProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        useCase = ResasUseCase(resasGateway: ResasGatewayMock())
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        useCase = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    /// 市区一覧取得するメソッドのテスト
    func testGetCities() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let result = try! useCase.getCitiesInPrefecture(prefCode: "\(PrefectureType.Osaka.prefCode)")
            .toBlocking(timeout: 5000).single()
        switch result {
        case let .success(response: response):
            response.result?.forEach { detail in
                guard let bigCityFlag = detail.bigCityFlag, let cityName = detail.cityName else {
                    XCTFail()
                    return
                }
                // 政令指定都市が含まれていないこと
                XCTAssertTrue(bigCityFlag != "2")
                // 市区のみに絞り込まれていること
                XCTAssertTrue(cityName.isCheckRegularExpression(pattern: "^.*[市区]$"))
            }
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
