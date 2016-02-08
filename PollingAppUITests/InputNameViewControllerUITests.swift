//
//  InputNameViewControllerUITests.swift
//  PollingApp
//
//  Created by Odin on 2016-02-07.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import XCTest

class InputNameViewControllerUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testTapReturn() {
    
    let app = XCUIApplication()
    app.buttons["Submit"].tap()
    
    let okButton = app.alerts["Please add a name"].collectionViews.buttons["Ok"]
    okButton.tap()
    
    let yourNameTextField = app.textFields["Your name"]
    yourNameTextField.tap()
    app.typeText("\r")
    okButton.tap()
    yourNameTextField.typeText("Jimmy")
    app.typeText("\r")
  }
  
  func testTapButton() {
    
    
    let app = XCUIApplication()
    let submitButton = app.buttons["Submit"]
    submitButton.tap()
    
    let okButton = app.alerts["Please add a name"].collectionViews.buttons["Ok"]
    okButton.tap()
    
    let yourNameTextField = app.textFields["Your name"]
    yourNameTextField.tap()
    
    let yourNameElement = app.otherElements.containingType(.TextField, identifier:"Your name").element
    yourNameElement.tap()
    submitButton.tap()
    okButton.tap()
    yourNameTextField.tap()
    yourNameTextField.typeText("Jimmy")
    yourNameElement.tap()
    submitButton.tap()
    
  }
  
}
