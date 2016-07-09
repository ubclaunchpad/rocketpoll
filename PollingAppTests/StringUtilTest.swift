//
//  StringUtilTest.swift
//  PollingApp
//
//  Created by Sherry Yuan on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import XCTest
@testable import PollingApp

class StringUtilTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
  
  func testCleanText(){
    XCTAssertEqual("hello", StringUtil.cleanText("hello?"))
    XCTAssertEqual("hello", StringUtil.cleanText("hel[]lo"))
    XCTAssertEqual("", StringUtil.cleanText(""))
    XCTAssertEqual("123", StringUtil.cleanText("*123"))
    XCTAssertEqual("hello there", StringUtil.cleanText("hello# there"))
    XCTAssertEqual("a a a a", StringUtil.cleanText("a a a a "))
  }
  
  func testCleanNameText(){
    XCTAssertEqual("hello", StringUtil.cleanNameText("hello?"))
    XCTAssertEqual("hello", StringUtil.cleanNameText(" hello!!!"))
  }
}
