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
  func createNewQuestion(question: QuestionText) -> Question {
    
    let timeStamp = NSDate().timeIntervalSince1970
    let endStamp = NSDate().timeIntervalSince1970 + 60; //TODO: CHANGE THIS
    let QID = ["Author": "\(currentUser)","Question": question, "startTimeStamp": timeStamp, "endTimeStamp": endStamp]
    let fbd:FirebaseData = FirebaseData()
    let key = fbd.postToFirebaseWithKey("QUESTIONSCREEN", child: "QID", children: QID) as QuestionID
    
    let sendQuestion = Question(QID: key, AIDS: [AnswerID](), author: currentUser, questionText: question, endTimestamp: endStamp)
    
    return sendQuestion
  }
  
  func getSelectedQuestion() -> Question  {
    return selectedQuestion
  }
  
  func setSelectedQuestion(AIDS: [AnswerID], QID: QuestionID, questionText: QuestionText, author: Author, time: Double) {
    selectedQuestion.QID = QID
    selectedQuestion.AIDS = AIDS
    selectedQuestion.questionText = questionText
    selectedQuestion.author = author
    selectedQuestion.endTimestamp = time
  }
  
  
  func processQuestionData(completionHandler: (listofAllQuestions: [Question]) -> ()){
    let ref =  FIRDatabase.database().reference();
    ref.child("QUESTIONSCREEN").observeEventType(.Value, withBlock: { (snapshot) in
      if let postDict = snapshot.value as? [String : AnyObject] {
        let returnValue = self.parseQIDNodeAndItsChildren(postDict)
        completionHandler(listofAllQuestions: returnValue)
      }else {
        let listofQuestions = [Question]();
        completionHandler(listofAllQuestions: listofQuestions)
      }
      
    }) { (error) in
      print(error.localizedDescription)
    }
  }
  
  //MARK: - Helper Methods
  func parseQIDNodeAndItsChildren(data: NSDictionary) -> [Question] {
    var sendQuestion = [Question]();
    for (QID, children) in data  {
      let information = children as! [String : AnyObject]
      let tempQuestion = self.parseQuestionNodeInformation(information, QID:QID as! QuestionID)
      sendQuestion.append(tempQuestion);
    }
    
    return sendQuestion
  }
  
  func parseQuestionNodeInformation(data:NSDictionary, QID:QuestionID) -> Question{
    var sendAuthor = "";
    var sendAIDS = [AnswerID]();
    var sendQuestionText:QuestionText = "";
    var sendEndTimeStamp = 0.0;
    
    for (key,value) in data {
      let keyAsString  = key as! String
      switch keyAsString  {
      case "Author" :
        sendAuthor = value as! Author
      case "Question":
        sendQuestionText = value as! QuestionText
      case "AIDS":
        sendAIDS = self.parseAIDs(value as! [String: AnyObject]);
      case "endTimeStamp":
        sendEndTimeStamp = value as! Double
      default: break
      }
    }
    let tempQuestion = Question(QID:QID, AIDS:sendAIDS, author: sendAuthor, questionText: sendQuestionText, endTimestamp: sendEndTimeStamp);
    return tempQuestion;
  }
  
  func parseAIDs(data:NSDictionary) -> [AnswerID] {
    var sendAIDS = [AnswerID]();
    for (_, AID) in data {
      sendAIDS.append(AID as! AnswerID)
    }
    return sendAIDS
  }
  
  
  func getListOfQuestionsUserCreated() -> [QuestionID] {
    return ["Q1", "Q2", "Q3"]
  }
  
  func isQuestionAnswered(questionId: QuestionID) -> Bool {
    return true
  }
  
  //MARK: - Remove Question Information -
  func removeQuestion(questionId: QuestionID) -> Bool {
    let ref =  FIRDatabase.database().reference();
    ref.child("QUESTIONSCREEN/\(questionId)").removeAllObservers()
    ref.child("QUESTIONSCREEN").child("\(questionId)").removeValue()
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
  
  func segueTotoPollAdminVCFromCampaign() -> SegueName {
    return Segues.toPollAdminVCFromCampaign
  }
  
}
