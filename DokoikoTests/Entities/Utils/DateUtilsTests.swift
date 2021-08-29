//
//  DateUtilsTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/05/03.
//

@testable import Dokoiko
import XCTest

class DateUtilsTests: XCTestCase {
    private var dateUtils: DateUtils!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        dateUtils = DateUtils()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dateUtils = nil
        super.tearDown()
    }

    /// Dateを任意のフォーマット文字列に変換するメソッドのテスト
    func testGetFormatterStrJP() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let date = calendar.date(from: DateComponents(year: 2020, month: 4, day: 10, hour: 21, minute: 0, second: 20))
        let formatDateStr = dateUtils.getFormatterStrJP(date: date!, formatter: "yyyy年MM月dd日HH時mm分ss秒")
        XCTAssertEqual(formatDateStr, "2020年04月10日21時00分20秒")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
