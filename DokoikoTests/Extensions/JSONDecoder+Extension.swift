//
//  JSONDecoder+Extension.swift
//  DokoikoTests
//
//  Created by 岡崎伸也 on 2021/04/25.
//

@testable import Dokoiko
import XCTest

class JSONDecoder_Extension: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let object: WikiDataResponseEntity? = JSONDecoder().decodeFromJsonFile(bundle: Bundle(for: type(of: self)),
                                                                               fileName: "wikiDataQ750569")
        XCTAssertEqual(object?.entities?["Q750569"]?.labels?.ja?.value, "加古川市")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
