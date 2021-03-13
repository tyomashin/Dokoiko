//
//  AppDataTests.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/03/14.
//

@testable import Dokoiko
import XCTest

class AppDataTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // UserDefaults にアクセスするラッパーのテスト
    func testAppDataAccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 初期化フラグ
        // デフォルト値テスト
        XCTAssertEqual(AppData.firstLaunchFlag, false)
        // 値の変更が反映されているかテスト
        AppData.firstLaunchFlag = true
        XCTAssertEqual(AppData.firstLaunchFlag, true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
