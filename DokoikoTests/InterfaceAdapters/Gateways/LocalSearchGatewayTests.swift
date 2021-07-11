//
//  LocalSearchGatewayTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/07/11.
//

@testable import Dokoiko
import OHHTTPStubs
import RxBlocking
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class LocalSearchGatewayTests: XCTestCase {
    var apiMock: LocalSearchAPIClientProtocolMock!
    var gateway: LocalSearchGateway!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiMock = LocalSearchAPIClientProtocolMock()
        gateway = LocalSearchGateway(localSearchClient: apiMock)
        disposeBag = DisposeBag()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiMock = nil
        gateway = nil
        disposeBag = nil
        scheduler = nil
        testScheduler = nil
    }

    /// APIレスポンスをEntityに変換する処理のテスト
    func testTranslateToEntity() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        /// API Clientモックが返すデータを定義
        let sampleFeatureFirst = LocalSearchAPIFeature(
            id: "aaa",
            gid: "aaa",
            name: "sample1",
            geometry: LocalSearchAPIGeometry(type: "", coordinates: "35.000,123.55556666"),
            category: [],
            property: LocalSearchAPIProperty(
                uid: "",
                cassetteId: "",
                address: "東京都新宿区",
                tel1: "080-1234-5678",
                genre: [LocalSearchAPIGenre(code: "", name: "genre1"), LocalSearchAPIGenre(code: "", name: "genre2")],
                leadImage: "https://sample1"
            )
        )

        let sampleFeatureLast = LocalSearchAPIFeature(
            id: "aaa",
            gid: "aaa",
            name: "sample2",
            geometry: LocalSearchAPIGeometry(type: "", coordinates: "55.000,150.55556666"),
            category: [],
            property: LocalSearchAPIProperty(
                uid: "",
                cassetteId: "",
                address: "大阪府中央区",
                tel1: "111-2345-6780",
                genre: [LocalSearchAPIGenre(code: "", name: "genre3"), LocalSearchAPIGenre(code: "", name: "genre4")],
                leadImage: "https://sample2"
            )
        )

        let single = Single<ApiResponseEntity<LocalSearchAPIResponse>>.create { single in
            let response = LocalSearchAPIResponse(resultInfo: nil, feature: [sampleFeatureFirst, sampleFeatureLast])
            single(.success(.success(response: response)))
            return Disposables.create()
        }

        apiMock.given(.getSpot(cityCode: "1", startIndex: 1, category: .value(.leisure), willReturn: single))
        apiMock.given(.getSpot(lat: 0, lng: 0, startIndex: 1, category: .value(.lifestyle), willReturn: single))

        let resultWithCityCode = try! gateway.getSpot(cityCode: "1", startIndex: 1, category: .leisure).toBlocking(timeout: 5000).single()
        let resultWithLocation = try! gateway.getSpot(lat: 0, lng: 0, startIndex: 1, category: .lifestyle).toBlocking(timeout: 5000).single()

        /* 評価 */
        switch resultWithCityCode {
        case let .success(response):
            XCTAssertEqual(response.count, 2)
            // APIレスポンスの型が、アプリ内部で使用するEntity型に変換されていることを確認
            let firstEntity = response.first!
            let lastEntity = response.last!
            XCTAssertEqual(firstEntity.name, sampleFeatureFirst.name)
            XCTAssertEqual(firstEntity.lat, 35.000)
            XCTAssertEqual(firstEntity.lng, 123.55556666)
            XCTAssertEqual(firstEntity.genre, ["genre1", "genre2"])
            XCTAssertEqual(firstEntity.address, sampleFeatureFirst.property?.address)
            XCTAssertEqual(firstEntity.tel, sampleFeatureFirst.property?.tel1)
            XCTAssertEqual(firstEntity.imageUrl, sampleFeatureFirst.property?.leadImage)

            XCTAssertEqual(lastEntity.name, sampleFeatureLast.name)
            XCTAssertEqual(lastEntity.lat, 55.000)
            XCTAssertEqual(lastEntity.lng, 150.55556666)
            XCTAssertEqual(lastEntity.genre, ["genre3", "genre4"])
            XCTAssertEqual(lastEntity.address, sampleFeatureLast.property?.address)
            XCTAssertEqual(lastEntity.tel, sampleFeatureLast.property?.tel1)
            XCTAssertEqual(lastEntity.imageUrl, sampleFeatureLast.property?.leadImage)
        case .error:
            XCTFail()
        }

        switch resultWithLocation {
        case let .success(response: response):
            XCTAssertEqual(response.count, 2)
            // APIレスポンスの型が、アプリ内部で使用するEntity型に変換されていることを確認
            let firstEntity = response.first!
            let lastEntity = response.last!
            XCTAssertEqual(firstEntity.name, sampleFeatureFirst.name)
            XCTAssertEqual(firstEntity.lat, 35.000)
            XCTAssertEqual(firstEntity.lng, 123.55556666)
            XCTAssertEqual(firstEntity.genre, ["genre1", "genre2"])
            XCTAssertEqual(firstEntity.address, sampleFeatureFirst.property?.address)
            XCTAssertEqual(firstEntity.tel, sampleFeatureFirst.property?.tel1)
            XCTAssertEqual(firstEntity.imageUrl, sampleFeatureFirst.property?.leadImage)

            XCTAssertEqual(lastEntity.name, sampleFeatureLast.name)
            XCTAssertEqual(lastEntity.lat, 55.000)
            XCTAssertEqual(lastEntity.lng, 150.55556666)
            XCTAssertEqual(lastEntity.genre, ["genre3", "genre4"])
            XCTAssertEqual(lastEntity.address, sampleFeatureLast.property?.address)
            XCTAssertEqual(lastEntity.tel, sampleFeatureLast.property?.tel1)
            XCTAssertEqual(lastEntity.imageUrl, sampleFeatureLast.property?.leadImage)
        case .error:
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
