//
//  MathUtilTest.swift
//  PollingApp
//
//  Created by Sherry Yuan on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import XCTest
@testable import PollingApp

class MathUtilTest: XCTestCase {
  
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
  
  func testCalculatePercentage() {
    XCTAssertEqual(50.0, MathUtil.convertTallyResultsToPercentage(2, denominator: 4))
    XCTAssertEqual(100.0, MathUtil.convertTallyResultsToPercentage(35, denominator: 35))
    XCTAssertEqual(0, MathUtil.convertTallyResultsToPercentage(0, denominator: 100))
    XCTAssertEqual(67.0, MathUtil.convertTallyResultsToPercentage(2, denominator: 3))
  }

}
