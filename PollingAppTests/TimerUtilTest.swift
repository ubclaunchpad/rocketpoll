//
//  TimerUtilTest.swift
//  PollingApp
//
//  Created by Odin on 2016-07-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import XCTest
@testable import PollingApp

class TimerUtilTest: XCTestCase {
  
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
  
  func testFormatSecondsToHHMMSS() {
    XCTAssertEqual("00:00:05", TimerUtil.formatSecondsToHHMMSS(5))
    XCTAssertEqual("00:01:00", TimerUtil.formatSecondsToHHMMSS(60))
    XCTAssertEqual("01:00:00", TimerUtil.formatSecondsToHHMMSS(3600))
    XCTAssertEqual("00:50:01", TimerUtil.formatSecondsToHHMMSS(3001))
    XCTAssertEqual("11:11:11", TimerUtil.formatSecondsToHHMMSS(40271))
    XCTAssertEqual("100:11:11", TimerUtil.formatSecondsToHHMMSS(360671))
  }
  
  func testFormatSecondsToDays() {
    XCTAssertEqual(UIStringConstants.lessThanOneDayLeft,
                   TimerUtil.formatSecondsToDays(TimerUtil.secondsInADay-1))
    XCTAssertEqual("1 Day", TimerUtil.formatSecondsToDays(TimerUtil.secondsInADay))
    XCTAssertEqual("2 Days", TimerUtil.formatSecondsToDays(TimerUtil.secondsInADay*2))
  }
  
  func testTotalSecondsToString() {
    XCTAssertEqual("00:00:05", TimerUtil.totalSecondsToString(5))
    XCTAssertEqual("00:01:00", TimerUtil.totalSecondsToString(60))
    XCTAssertEqual("01:00:00", TimerUtil.totalSecondsToString(3600))
    XCTAssertEqual("00:50:01", TimerUtil.totalSecondsToString(3001))
    XCTAssertEqual("11:11:11", TimerUtil.totalSecondsToString(40271))
    
    XCTAssertEqual("1 Day Left", TimerUtil.totalSecondsToString(TimerUtil.secondsInADay))
    XCTAssertEqual("2 Days Left", TimerUtil.totalSecondsToString(TimerUtil.secondsInADay*2))
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }
  
}
