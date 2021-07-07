//
//  DataBaseGatewayTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/05/01.
//

@testable import Dokoiko
import OHHTTPStubs
import RxBlocking
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class DataBaseGatewayTests: XCTestCase {
    var databaseMock: DatabaseProtocolMock!
    var gateway: DataBaseGatewayProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // SwiftyMockyで作成したモックを使う
        databaseMock = DatabaseProtocolMock()
        gateway = DataBaseGateway(database: databaseMock)
        disposeBag = DisposeBag()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        databaseMock = nil
        gateway = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    /// 市区情報の検索結果操作周りのテスト
    /// memo: Gateway で Realmオブジェクト <-> Entityの変換ができているかを主に確認
    func testCitySearchResults() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // 検索結果格納のテスト
        let prefCode = 1
        let cityName = "京都市"
        let cityCode = "00000"
        // モックのメソッドが返す値を定義
        let single = Single<Result<SearchResultObject, DataBaseError>>.create { single in
            let result = SearchResultObject(id: "id", prefCode: prefCode, cityName: cityName)
            result.cityCode = cityCode
            result.lat.value = nil
            result.lng.value = nil
            single(.success(.success(result)))
            return Disposables.create()
        }
        // モックが返すデータを指定
        databaseMock.given(.saveCitySearchResult(prefCode: Parameter<Int>(integerLiteral: prefCode),
                                                 cityName: Parameter<String>(stringLiteral: cityName),
                                                 cityCode: Parameter<String?>(stringLiteral: cityCode),
                                                 lat: nil, lng: nil,
                                                 willReturn: single))

        var result = try! gateway.saveCitySearchResult(prefCode: prefCode, cityName: cityName, cityCode: cityCode, lat: nil, lng: nil)
            .toBlocking(timeout: 1000).single()
        switch result {
        case let .success(object):
            XCTAssertEqual(prefCode, object.prefCode)
            XCTAssertEqual(cityName, object.cityName)
            XCTAssertEqual(cityCode, object.cityCode)
            let prefName = PrefectureType.allCases.first(where: { $0.prefCode == prefCode })?.name
            XCTAssertEqual(prefName!, object.prefName)
        case .failure:
            XCTFail()
        }

        // 検索結果の緯度経度更新テスト
        let lat: Double = 30.123
        let lng: Double = 135.45678
        let singleSetLocation = Single<Result<SearchResultObject, DataBaseError>>.create { single in
            let result = SearchResultObject(id: "id", prefCode: 1, cityName: "cityName")
            result.lat.value = lat
            result.lng.value = lng
            single(.success(.success(result)))
            return Disposables.create()
        }
        // モックが返すデータを指定
        databaseMock.given(.setCityLocation(id: "id", lat: Parameter<Double>(floatLiteral: lat),
                                            lng: Parameter<Double>(floatLiteral: lng),
                                            willReturn: singleSetLocation))
        result = try! gateway.setCityLocation(id: "id", lat: lat, lng: lng).toBlocking(timeout: 5000).single()
        switch result {
        case let .success(object):
            XCTAssertEqual(lat, object.lat)
            XCTAssertEqual(lng, object.lng)
        case .failure:
            XCTFail()
        }

        // 検索結果の一覧取得テスト
        var searchResultList = [SearchResultObject]()
        let object1 = SearchResultObject(id: "1", prefCode: 2, cityName: "京都市")
        let object2 = SearchResultObject(id: "2", prefCode: 27, cityName: "神戸市")
        searchResultList.append(object1)
        searchResultList.append(object2)
        let singleGetSearchResult = Single<Result<[SearchResultObject], DataBaseError>>.create { single in
            single(.success(.success(searchResultList)))
            return Disposables.create()
        }
        // モックが返すデータを指定
        databaseMock.given(.getCitySearchResult(willReturn: singleGetSearchResult))
        let resultSearchResult = try! gateway.getCitySearchResult().toBlocking(timeout: 5000).single()
        switch resultSearchResult {
        case let .success(response):
            XCTAssertEqual(searchResultList.count, response.count)
            for index in 0 ..< searchResultList.count {
                let object = searchResultList[index]
                let entity = response[index]
                XCTAssertEqual(object.id, entity.id)
                XCTAssertEqual(object.prefCode, entity.prefCode)
                let prefName = PrefectureType.allCases.first(where: { $0.prefCode == object.prefCode })?.name
                XCTAssertEqual(entity.prefName, prefName)
                XCTAssertEqual(object.cityName, entity.cityName)
            }
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
