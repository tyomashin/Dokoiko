//
//  WikiDataUseCaseTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/25.
//

@testable import Dokoiko
import RxBlocking
import RxSwift
import RxTest
import XCTest

class WikiDataUseCaseTests: XCTestCase {
    var wikiDataGatewayMock: WikiDataGatewayProtocolMock!
    var useCase: WikiDataUseCaseProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        wikiDataGatewayMock = WikiDataGatewayProtocolMock()
        useCase = WikiDataUseCase(wikiDataGateway: wikiDataGatewayMock)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        wikiDataGatewayMock = nil
        useCase = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    /// Wikiデータ取得のメソッドのテスト
    func testGetWikiData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // モックの準備
        let single = Single<ApiResponseEntity<WikiDataResponseEntity>>.create { single in
            var result: ApiResponseEntity<WikiDataResponseEntity>
            // ローカルのJsonファイルをデコードしてオブジェクト初期化
            if let object: WikiDataResponseEntity = JSONDecoder().decodeFromJsonFile(bundle: Bundle(for: type(of: self)),
                                                                                     fileName: "wikiDataQ750569")
            {
                result = .success(response: object)
            } else {
                result = .error(error: .dataEmptyError)
            }
            single(.success(result))
            return Disposables.create()
        }
        wikiDataGatewayMock.given(.getWikiData(wikiCode: "Q750569", willReturn: single))

        let result = try! useCase.getWikiData(wikiCode: "Q750569").toBlocking(timeout: 5000).single()
        switch result {
        case let .success(response: response):
            XCTAssertTrue(response.entities != nil)
            XCTAssertEqual(response.entities?["Q750569"]?.labels?.ja?.value, "加古川市")
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
