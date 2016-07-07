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
  
  // Create a list of AIDS in the QuestionScreen node
  func createAnswerIDs(questionID:QuestionID, answerText:[AnswerText]) -> [String]  {
    
    var i = 0;
    let fBD:FirebaseData = FirebaseData();
    var answerIDS = [String]();
    var answerID:String
    for answer in answerText {
      let children = ["tally": "0", "answer": answer , "isCorrect": false];
      
      answerID = fBD.postToFirebaseWithKey("ANSWERS/AIDS", child: "AID" , children: children);
      answerIDS.append(answerID);
      i += 1;
    }
    
    var answerIDsFireBase = [String:String]();
    i = 1;
    for answerID in answerIDS {
      answerIDsFireBase["AID\(i)"] = answerID
      i += 1;
    }
    fBD.postToFirebaseWithOutKey("QUESTIONSCREEN/\(questionID as String)", child: "AIDS", children: answerIDsFireBase);
    return answerIDS
  }
  
  func processAnswerData(selectedAnswerIDs:[AnswerID],completionHandler: (listofAllAnswers: [Answer]) -> ()) {
    
    let ref =  FIRDatabase.database().reference();
    ref.child("ANSWERS").child("AIDS").observeEventType(.Value, withBlock: { (snapshot) in
      let answerNodes = snapshot.value as! [String : AnyObject]
      let  sendAnswerData = self.parseAIDNodeAndItsChildren(answerNodes, selectedAnswerIDs: selectedAnswerIDs)
      completionHandler(listofAllAnswers: sendAnswerData)
      
    }) { (error) in
      print(error.localizedDescription)
    }
    
  }
  
  
  func parseAIDNodeAndItsChildren(data:NSDictionary,selectedAnswerIDs:[AnswerID]) -> [Answer] {
    var sendAnswerData = [Answer]()
    for (AID, children) in data {
      if (selectedAnswerIDs.contains(AID as! AnswerID)) {
        let information = children as! [String : AnyObject]
        let tempAnswer = self.parseAnswerNodeInformation(information, AID: AID as! AnswerID)
        sendAnswerData.append(tempAnswer)
      }
    }
    return  sendAnswerData
    
  }
  
  func parseAnswerNodeInformation(data:NSDictionary, AID: AnswerID) -> Answer{
    var sendTally = 0;
    var sendIsCorrect = false;
    var sendAnswerText = "";
    
    for (key,value) in data {
      let keyAsString = key as! String
      switch keyAsString {
      case "answer" :
        sendAnswerText = value as! AnswerText
      case "isCorrect":
        sendIsCorrect = value as! Bool
      case "tally":
        sendTally = Int(value as! String)!
      default: break
        
      }
    }
    
    let tempAnswer = Answer(AID: AID, isCorrect: sendIsCorrect, tally: sendTally, answerText: sendAnswerText)
    
    return tempAnswer;
  }
  
  
  func setCorrectAnswer(answerId: AnswerID, isCorrectAnswer: Bool) -> Bool {
    let fBD:FirebaseData = FirebaseData();
    fBD.updateFirebaseDatabase("ANSWERS/AIDS/\(answerId as String)", targetNode: "isCorrect", desiredValue: isCorrectAnswer)
    
    return true
  }
  
  func setUserAnswer(currentTally: Int, answerID: AnswerID) -> Bool {
    let currentTally = 1 + currentTally;
    let sendTally = String(currentTally);
    print(" has this many votes: \(currentTally)")
    let fBD:FirebaseData = FirebaseData();
    fBD.updateFirebaseDatabase("ANSWERS/AIDS/\(answerID as String)", targetNode: "tally", desiredValue: sendTally)
    return true
  }
  
  //MARK: - Get Answer Information -
  func isCorrectAnswer(answerId: AnswerID) -> Bool {
    return true
  }
  
  func getCorrectAnswer(questionID: QuestionID) -> AnswerID {
    return "A1"
  }
}
