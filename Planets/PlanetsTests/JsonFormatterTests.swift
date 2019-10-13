//
//  JsonFormatterTests.swift
//  PlanetsTests
//
//  Created by Pip Elise Russell on 12/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import XCTest
@testable import Planets

class JsonFormatterTests: XCTestCase {

    var formatter: JsonFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = JsonFormatter()
    }

    override func tearDown() {
        
    }

    func testJsonToInt() {
        XCTAssertEqual(formatter.jsonToInt(json: "15"), 15)
        XCTAssertEqual(formatter.jsonToInt(json: "Nope"), 0)
        XCTAssertEqual(formatter.jsonToInt(json: Date()), 0)
        XCTAssertEqual(formatter.jsonToInt(json: 20), 20)
        
    }

    func testJsonToDate() {
        XCTAssertEqual(formatter.jsonToDate(json: "2014-12-10T11:35:48.479000Z"), Date(timeIntervalSinceReferenceDate: 439904148.4790001))
        XCTAssertEqual(formatter.jsonToDate(json: Date(timeIntervalSince1970: 5)), Date(timeIntervalSince1970: 5))
        XCTAssertNil(formatter.jsonToDate(json: "Last tuesday"))
        XCTAssertNil(formatter.jsonToDate(json: 5))
    }
    
    func testJsonToURL() {
        XCTAssertEqual(formatter.jsonToURL(json: "www.google.com"), URL(string: "www.google.com"))
        XCTAssertEqual(formatter.jsonToURL(json: URL(string: "www.google.com")), URL(string: "www.google.com"))
        XCTAssertEqual(formatter.jsonToURL(json: "Bob"), URL(string: "Bob"))
        XCTAssertNil(formatter.jsonToURL(json: 5))
        XCTAssertNil(formatter.jsonToURL(json: Date()))
        
    }
    
    func testStringOrBlank() {
        XCTAssertEqual(formatter.stringOrBlank(json: "Hello"), "Hello")
        XCTAssertEqual(formatter.stringOrBlank(json: 5), "")
        XCTAssertEqual(formatter.stringOrBlank(json: nil), "")
        XCTAssertEqual(formatter.stringOrBlank(json: Date()), "")
    }
    
    func testJsonToString() {
        XCTAssertEqual(formatter.jsonToString(json: "Test"), "Test")
        XCTAssertNil(formatter.jsonToString(json: 5))
        XCTAssertNil(formatter.jsonToString(json: Date()))
        XCTAssertNil(formatter.jsonToString(json: nil))
    }

}
