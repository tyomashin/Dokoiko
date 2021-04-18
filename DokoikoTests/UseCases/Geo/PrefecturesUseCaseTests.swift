//
//  PrefecturesUseCaseTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/19.
//

@testable import Dokoiko
import RxBlocking
import RxSwift
import RxTest
import XCTest

class PrefecturesUseCaseTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var prefectures: PrefecturesUseCaseProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        prefectures = PrefecturesUseCase()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegionBlockList() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // 日本の8地域区分が返されているかテスト
        XCTAssertEqual(try prefectures.getRegionBlockList().toBlocking().first()?.count, 8)
        // 先頭と末端要素だけ最低限テスト
        XCTAssertEqual(try prefectures.getRegionBlockList().toBlocking().first()?.first, "北海道")
        XCTAssertEqual(try prefectures.getRegionBlockList().toBlocking().first()?.last, "九州")
    }

    func testPrefecturesInRegion() throws {
        // 各地域に含まれている都道府県の数をチェック
        // 北海道
        var index: Int = RegionalBlockType.allCases.firstIndex(of: .Hokkaido)!
        var regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 1)
        // 東北
        index = RegionalBlockType.allCases.firstIndex(of: .Tohoku)!
        regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 6)
        // 関東
        index = RegionalBlockType.allCases.firstIndex(of: .Kanto)!
        regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 7)
        // 中部
        index = RegionalBlockType.allCases.firstIndex(of: .Chubu)!
        regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 9)
        // 近畿
        index = RegionalBlockType.allCases.firstIndex(of: .Kinki)!
        regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 7)
        // 中国
        index = RegionalBlockType.allCases.firstIndex(of: .Chugoku)!
        regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 5)
        // 四国
        index = RegionalBlockType.allCases.firstIndex(of: .Shikoku)!
        regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 4)
        // 九州
        index = RegionalBlockType.allCases.firstIndex(of: .Kyushu)!
        regionCount = RegionalBlockType.allCases[index].prefectures.count
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, regionCount)
        XCTAssertEqual(try prefectures.getPrefecturesInRegion(index: index).toBlocking().first()?.count, 8)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
