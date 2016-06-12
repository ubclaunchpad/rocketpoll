//
//  QuestionModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation
import Firebase

extension ModelInterface: QuestionModelProtocol {

  //MARK: - Setting Question Information -
  func setNewQuestion(question: String) -> QuestionID {

    
    let timeStamp = NSDate().timeIntervalSince1970
    let endStamp = NSDate().timeIntervalSince1970 + 30; //TODO: CHANGE THIS
    let QID = ["Author": "Jon","Question": question, "startTimeStamp": timeStamp, "endTimeStamp": endStamp];
    let fbd:FirebaseData = FirebaseData();
    let key = fbd.postToFirebaseWithKey("QUESTIONSCREEN", child: "QID", children: QID) as QuestionID;

    return key
  }
  
  //MARK: - Getting Question Information -
  func getQuestion(questionId: QuestionID, snapshot:FIRDataSnapshot) -> String {
    let postDict = snapshot.childSnapshotForPath(questionId).value as! [String : AnyObject]
    return postDict["Question"] as! String
  }
  
  func getSelectedQuestionID() -> QuestionID {
    return selectedQuestionID
  }
  
    func setSelectedQuestionID(questionID:String){
        selectedQuestionID = questionID
    }
    
  func getListOfQuestions(snapshot:FIRDataSnapshot) -> [QuestionID] {
    let postDict = snapshot.value as! [String : AnyObject]
    
    
    var ListOfQuestions = [String]();
    for (QID, _) in postDict {
        ListOfQuestions.append(QID);
    }

    return ListOfQuestions
  }
  
  func getListOfQuestionsUserCreated() -> [QuestionID] {

    return ["Q1", "Q2", "Q3"]
  }
  
    
  func isQuestionAnswered(questionId: QuestionID) -> Bool {
    return true
  }
    
  //MARK: - Remove Question Information -
  func removeQuestion(questionId: QuestionID) -> Bool {
    return true
  }
  
  //MARK: - Segues -
  func segueToQuestionsUserCreated() -> SegueName {
    return Segues.toMainApp
  }
  
  func segueToQuestionsNearMe() -> SegueName {
    return Segues.toMainApp
  }
  
  func segueToQuestion() -> SegueName {
    return Segues.toPollUserViewController
  }
  
  func segueToCreateNewQuestion() -> SegueName {
    return Segues.toCreateQuestionView
  }
  func segueToQuestionsScreen() -> SegueName {
    return Segues.toQuestionsScreen
  }
  func segueToAdminScreen() -> SegueName {
    return Segues.toPollAdminScreen
  }
  func segueToResultsScreen() -> SegueName{
    return Segues.toPollResultsView
  }

}
