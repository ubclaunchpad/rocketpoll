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
  
  func processAnswerData(selectedAnswerIDs:[AnswerID], completionHandler: (listofAllAnswers: [Answer]) -> ()) {
    
    let ref =  FIRDatabase.database().reference()
    ref.child("ANSWERS").child("AIDS").observeEventType(.Value, withBlock: { (snapshot) in
      let answerNodes = snapshot.value as! [String : AnyObject]
      let  sendAnswerData = self.parseAIDNodeAndItsChildren(answerNodes, selectedAnswerIDs: selectedAnswerIDs)
      completionHandler(listofAllAnswers: sendAnswerData)
      
    }) { (error) in
      Log.error(error.localizedDescription)
    }
  }
  
  func getListOfUsersWhoVoteForGivenAnswer (answerID:AnswerID, completionHandler: (listOfUsers: [Author]) -> () ){
    let ref = FIRDatabase.database().reference()
    ref.child("ANSWERS/AIDS/\(answerID)/LISTOFUSERS").observeEventType(.Value, withBlock: { (snapshot) in
      if (snapshot.value as? [String : String]) != nil {
        let userNodes = snapshot.value as! [String : String]
        let listOfUsers = self.parseUsers(userNodes)
        completionHandler(listOfUsers: listOfUsers)
      } else {
        completionHandler(listOfUsers: [])
      }
      
    }) { (error) in
      Log.error(error.localizedDescription)
    }
  }
  
  func parseUsers(data:NSDictionary) -> [Author] {
    var sendUsers = [Author]()
    for (_, user) in data {
      sendUsers.append(user as! Author)
    }
    return sendUsers
  }
  
  
  func findYourAnswer(questionID:QuestionID,completionHandler: (yourAnswer:AnswerID) -> ()) {
    let ref =  FIRDatabase.database().reference();
    ref.child("Users").child(currentID).child("QuestionsAnswered").child(questionID).observeEventType(.Value, withBlock: { (snapshot) in
      if (snapshot.value as? String) != nil {
        let answerNode = snapshot.value as! String
        completionHandler(yourAnswer: answerNode)
      } else {
        completionHandler(yourAnswer:"")
      }
      
    }) { (error) in
      Log.error(error.localizedDescription)
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
    return sendAnswerData
    
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
  
  func setUserAnswer(answerID: AnswerID, increase: Bool) -> Bool {
    
    let ref = FIRDatabase.database().reference();
    ref.child("ANSWERS/AIDS/\(answerID as String)/tally").runTransactionBlock({
      (currentData:FIRMutableData) -> FIRTransactionResult in
      let value = currentData.value as? String
      if (value != nil) {
        var currentTally = 0
        if (increase) {
          currentTally = Int(value!)! + 1;
        } else {
          currentTally = Int(value!)! - 1;
        }
        let sendTally = String(currentTally);
        currentData.value = sendTally
      }
      return FIRTransactionResult.successWithValue(currentData)
    })
    
    return true
  }
  
  
  func rememberUser(answerID: AnswerID) {
    let child = [currentID: currentUser]
    let ref = FIRDatabase.database().reference()
    ref.child ("ANSWERS/AIDS/\(answerID)/LISTOFUSERS").updateChildValues(child)
  }
  
  func deleteUserFromAnswerNode (answerID: AnswerID){
    let ref = FIRDatabase.database().reference()
    ref.child ("ANSWERS/AIDS/\(answerID)/LISTOFUSERS/\(currentID)").removeValue()
  }
  
  func  rememberAnswer (questionID:QuestionID, answerID:AnswerID, completionHandler: (DontAllowRevoting: Bool) -> ()) {
    let ref = FIRDatabase.database().reference()
    let child = [questionID :  answerID]
    ref.child("Users").child("\(currentID)/QuestionsAnswered").observeSingleEventOfType(FIRDataEventType.Value, withBlock: { (snapshot) in
      if !(snapshot.childSnapshotForPath(questionID).exists()) {
        ref.child("Users").child("\(currentID)/QuestionsAnswered").updateChildValues(child)
        self.setUserAnswer(answerID, increase: true)
        self.rememberUser(answerID)
        completionHandler(DontAllowRevoting: false )
        return
        
      } else if (snapshot.childSnapshotForPath(questionID).value as! String != answerID) {
        
        let oldAnswerID = snapshot.childSnapshotForPath(questionID).value as! String
        self.deleteUserFromAnswerNode(oldAnswerID)
        self.setUserAnswer(oldAnswerID, increase: false)
        ref.child("Users").child("\(currentID)/QuestionsAnswered").updateChildValues(child)
        self.rememberUser(answerID)
        self.setUserAnswer(answerID, increase: true)
        completionHandler(DontAllowRevoting: false )
        return
      } else {
        
        completionHandler(DontAllowRevoting: true)
        return
      }
      
    })
    
  }
  //MARK: - Get Answer Information -
  func isCorrectAnswer(answerId: AnswerID) -> Bool {
    return true
  }
  
  func getCorrectAnswer(questionID: QuestionID) -> AnswerID {
    return "A1"
  }
}
