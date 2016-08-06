//
//  FirebaseTest.swift
//  PollingApp
//
//  Created by James Park on 2016-07-30.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import XCTest
import Firebase
@testable import PollingApp

class WriteReadFirebase:XCTestCase  {
  let currentUser = "TestWriteReadFirebaseUser" +  (StringUtil.generateRandomStringWithLength(5) as String)
  var questionString = "this is a test" + (StringUtil.generateRandomStringWithLength(5) as String)
  var testQID = ""
  var testAnswerText = [AnswerText]();
  
  var testAnswerIDs = [AnswerID]();
  
  
  override func setUp() {
    super.setUp()
    //number of Answers
    createAnswerText(2);
    
    // Create the question as the user on the simulator
    createQuestionAnswersToFirebase(questionString, answerTexts: testAnswerText, time: 10)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testWriteCheckValue () {
    
    var done = false;
    ModelInterface.sharedInstance.processQuestionData { (listofAllQuestions) in
      done = true
      
    }
    waitUntil(6) { done }
    XCTAssert(done, "Completion should be called")
    done = false
    // Check the answer
    
    ModelInterface.sharedInstance.processAnswerData(testAnswerIDs) { (listofAllAnswers) in
      done = true
    }
    
    waitUntil(6) { done }
    XCTAssert(done, "Completion should be called")
    
  }
  
  private func createAnswerText (size:Int) {
    for _ in 1...size {
      testAnswerText.append(StringUtil.generateRandomStringWithLength(5) as String)
    }
  }
  
  
  private func createQuestionAnswersToFirebase (questionString:QuestionText, answerTexts:[AnswerText], time: Int) {
    let question = ModelInterface.sharedInstance.createNewQuestion(questionString, questionDuration: time)
    testQID = question.QID
    testAnswerIDs = ModelInterface.sharedInstance.createAnswerIDs(testQID, answerText: answerTexts)
  }
  
  
  private func waitUntil(timeout: NSTimeInterval, predicate:(Void -> Bool)) {
    let timeoutTime = NSDate(timeIntervalSinceNow: timeout).timeIntervalSinceReferenceDate
    
    while (!predicate() && NSDate.timeIntervalSinceReferenceDate() < timeoutTime) {
      NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 5))
    }
  }
  
  
}
