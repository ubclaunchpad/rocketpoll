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
    func setNewQuestion(question: QuestionText) -> QuestionID {
        
        let timeStamp = NSDate().timeIntervalSince1970
        let endStamp = NSDate().timeIntervalSince1970 + 30; //TODO: CHANGE THIS
        let QID = ["Author": "\(currentUser)","Question": question, "startTimeStamp": timeStamp, "endTimeStamp": endStamp]
        let fbd:FirebaseData = FirebaseData()
        let key = fbd.postToFirebaseWithKey("QUESTIONSCREEN", child: "QID", children: QID) as QuestionID
        
        return key
    }
    
    func getSelectedQuestion() -> Question  {
        return selectedQuestion
    }
    
    func setSelectedQuestion(AIDS: [AnswerID], QID: QuestionID, questionText: QuestionText, author: Author) {
        selectedQuestion.QID = QID
        selectedQuestion.AIDS = AIDS
        selectedQuestion.questionText = questionText
        selectedQuestion.author = author
    }
    
    
    func processQuestionData(completionHandler: (listofAllQuestions: [Question], listofQuestionID: [QuestionID]) -> ()){
        let ref =  FIRDatabase.database().reference();
        ref.child("QUESTIONSCREEN").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let postDict = snapshot.value as! [String : AnyObject]
            let returnValue = self.parseQIDNodeAndItsChildren(postDict)
            completionHandler(listofAllQuestions: returnValue.0, listofQuestionID: returnValue.1)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Helper Methods
    func parseQIDNodeAndItsChildren(data: NSDictionary) -> ([Question],[QuestionID]) {
        var sendQuestion = [Question]();
        var listOfQuestionID = [QuestionID]()
        for (QID, children) in data  {
            let information = children as! [String : AnyObject]
            let tempQuestion = self.parseQuestionNodeInformation(information, QID:QID as! QuestionID)
            sendQuestion.append(tempQuestion);
            listOfQuestionID.append(QID as! QuestionID)
        }
        
        return (sendQuestion, listOfQuestionID)
    }

    func parseQuestionNodeInformation(data:NSDictionary, QID:QuestionID) -> Question{
        var sendAuthor = "";
        var sendAIDS = [AnswerID]();
        var sendQuestionText:QuestionText = "";
        
        for (key,value) in data {
            let keyAsString  = key as! String
            switch keyAsString  {
            case "Author" :
                sendAuthor = value as! Author
            case "Question":
                sendQuestionText = value as! QuestionText
            case "AIDS":
                sendAIDS = self.parseAIDs(value as! [String: AnyObject]);
            default: break
            }
        }
        let tempQuestion = Question(QID:QID, AIDS:sendAIDS, author: sendAuthor, questionText: sendQuestionText);
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
