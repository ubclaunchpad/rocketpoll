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
  func getQuestion(questionId: QuestionID) -> String {
    return "Is this a question?"
  }
  
    
    func processQuestionData(completionHandler: (listofAllQuestions: [QuestionC]) -> ()){
         let ref =  FIRDatabase.database().reference();
         ref.child("QUESTIONSCREEN").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            let postDict = snapshot.value as! [String : AnyObject]
            var sendQuestionC = [QuestionC]();
            var sendQID = "";
            var sendAuthor = "";
            var sendAIDS = [String]();
            var sendQuestionText = "";
            for (QID, data) in postDict {
                sendQID = QID;
                let information = data as! [String : AnyObject]
                
                for (key,value) in information {
                    
                    if (key == "Author") {
                        sendAuthor = value as! String ;
                    }
                    if (key == "Question") {
                        sendQuestionText = value as! String ;
                    }
                    if (key == "AIDS") {
                        let AIDS = value as! [String: AnyObject]
                        for (_,AID) in AIDS {
                            sendAIDS.append(AID as! String)
                        }
                    }
                }
                let tempQuestionC = QuestionC(QID:sendQID, AIDS:sendAIDS, author: sendAuthor, questionText: sendQuestionText);
                sendQuestionC.append(tempQuestionC);
            }
            
            completionHandler(listofAllQuestions: sendQuestionC)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
  func getQuestionID() -> QuestionID {
    return "Q1"
  }
  
  func getListOfQuestions() -> [QuestionID] {
    return ["Q1", "Q2", "Q3"]
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
