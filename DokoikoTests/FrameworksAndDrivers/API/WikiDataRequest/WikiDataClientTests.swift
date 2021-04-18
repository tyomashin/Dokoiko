//
//  WikiDataClientTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/11.
//

@testable import Dokoiko
import RxBlocking
import RxSwift
import RxTest
import XCTest

class WikiDataClientTests: XCTestCase {
    var wikiDataClient: WikiDataClientProtocol!
    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        disposeBag = DisposeBag()
        wikiDataClient = WikiDataClient()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        wikiDataClient = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }

    /// WikiCode からウィキデータを取得するテスト
    func testGetWikiData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // FIXME: Mockingjayを導入してサーバーのモックを作成する
        let result = try! wikiDataClient.getWikiData(wikiCode: "Q750569").toBlocking(timeout: 5000).single()
        switch result {
        case let .success(response: response):
            XCTAssertEqual(response.entities?["Q750569"]?.labels?.ja?.value, "加古川市")
        case .error(error: _):
            XCTFail()
        }
    }
}
