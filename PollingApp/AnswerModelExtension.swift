//
//  AnswerModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation
import Firebase

extension ModelInterface: AnswerModelProtocol {
  
  func randomStringWithLength (len : Int) -> NSString {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    var randomString : NSMutableString = NSMutableString(capacity: len)
    
    for (var i=0; i < len; i++){
      var length = UInt32 (letters.length)
      var rand = arc4random_uniform(length)
      randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString
  }
  
  
  //MARK: Setting Answer Information -
  func setNewAnswer(answer: String, questionID: QuestionID, i:NSInteger) -> AnswerID {
//    let timeStamp = NSDate().timeIntervalSince1970
//    let endStamp = NSDate().timeIntervalSince1970 + 30; //TODO: CHANGE THIS
//    let QID = ["Author": "Jon","Question": question, "startTimeStamp": timeStamp, "endTimeStamp": endStamp];
//    let fbd:FirebaseData = FirebaseData();
//    let key = fbd.postToFirebaseWithKey("QUESTIONS", child: "QID", children: QID) as QuestionID;
    
    let fBD:FirebaseData = FirebaseData();
    
    let ref =  FIRDatabase.database().reference();
    
    let key = ref.child("AID").childByAutoId().key
    fBD.postToFirebaseWithOutKey("QUESTIONSCREEN/\(questionID as String)", child: "AIDS", children: ["AID\(i)":key]);
  
    
//    let children = ["tally": "0", "answer": answer, "isCorrect": "correct"];
//    let AID = ["\(key)": children ];
//    let Answers = ["Answers": AID ];
//    fBD.postToFirebaseWithOutKey("QUESTIONS", child: questionID as String, children: Answers)
    
      return "A1"
  }
  
  func setCorrectAnswer(answerId: AnswerID, isCorrectAnswer: Bool) -> Bool {
    return true
  }
  
  func setUserAnswer(questionId: QuestionID, answerID: AnswerID) -> Bool {
    return true
  }
  
  //MARK: - Get Answer Information -
  func isCorrectAnswer(answerId: AnswerID) -> Bool {
    return true
  }
  
  func getCorrectAnswer(questionID: QuestionID) -> AnswerID {
    return "A1"
  }
  
  func getAnswer(answerId: AnswerID) -> String {
    return "This is the answer"
  }
  
  func getListOfAnswerIDs(questionId: QuestionID) -> [AnswerID] {
    return ["A1","A2","A3","A4"]
  }
  
  func getSumOfUsersThatSubmittedAnswers(questionID: QuestionID) -> Int {
    return 40
  }
  
    func getNumberOfUsersThatGaveThisAnswer(questionID: QuestionID, answerID: AnswerID) -> Int {

    return 10
  }

}
