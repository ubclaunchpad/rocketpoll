//
//  StringUtilTest.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import XCTest
@testable import PollingApp

class StringUtilTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testFillinString() {
        XCTAssertEqual("Poll ended 5 minutes ago", StringUtil.fillInString(UITimeRemaining.endedMinutes, time: 5))
        XCTAssertEqual("Poll ends in 5 minutes", StringUtil.fillInString(UITimeRemaining.endsMinutes, time: 5))
        XCTAssertEqual("Poll ended 1 hour ago", StringUtil.fillInString(UITimeRemaining.endedHour, time: 1))
        XCTAssertEqual("Poll ended 5 hours ago", StringUtil.fillInString(UITimeRemaining.endedHours, time: 5))
        XCTAssertEqual("Poll ends in 1 hour", StringUtil.fillInString(UITimeRemaining.endsHour, time: 1))
        XCTAssertEqual("Poll ends in 5 hours", StringUtil.fillInString(UITimeRemaining.endsHours, time: 5))
        XCTAssertEqual("Poll ends in 5 hours", StringUtil.fillInString(UITimeRemaining.endsHours, time: 5))
        XCTAssertEqual("Poll ended a couple moments ago", StringUtil.fillInString(UITimeRemaining.endedMoments, time: 5))
    }
  
  func testCleanText(){
    XCTAssertEqual("hello?", StringUtil.cleanText("hello?"))
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
