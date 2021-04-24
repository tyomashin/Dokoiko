//
//  String+ExtensionTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/23.
//

@testable import Dokoiko
import XCTest

class String_ExtensionTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// 正規表現の判定メソッドのテスト
    /// （備忘録も兼ねていくつかの正規表現パターンでテストしている）
    func testIsCheckRegularExpression() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // 文字列末尾に「町」or「村」がついていない正規表現パターン
        var pattern = "^.*[^町村]$"
        var testStr = "神戸市"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "吉田町"
        XCTAssertFalse(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "田中村"
        XCTAssertFalse(testStr.isCheckRegularExpression(pattern: pattern))

        // 0〜100までの数字のみの正規表現パターン
        pattern = "^([0-9]|[1-9][0-9]|100)$"
        testStr = "0"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "23"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "100"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "-10"
        XCTAssertFalse(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "101"
        XCTAssertFalse(testStr.isCheckRegularExpression(pattern: pattern))

        // 少数第一位までの正規表現パターン
        pattern = "^[-]?([0-9]|[1-9][0-9]*)([.][0-9]?)?$"
        testStr = "10.1"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "5.0"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "109.5"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "-23.9"
        XCTAssertTrue(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "24.29"
        XCTAssertFalse(testStr.isCheckRegularExpression(pattern: pattern))
        testStr = "-.9"
        XCTAssertFalse(testStr.isCheckRegularExpression(pattern: pattern))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
