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
    func setAnswerIDS(questionID:QuestionID, answerString:[String]) -> [String]  {
        
        var i = 0;
        let fBD:FirebaseData = FirebaseData();
        var answerIDS = [String]();
        var answerID:String
        for answer in answerString {
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
    
    func processAnswerData(selectedAnswerIDs:[String],completionHandler: (listofAllAnswers: [AnswerC]) -> ()) {
        
        let ref =  FIRDatabase.database().reference();
        ref.child("ANSWERS").child("AIDS").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            let postDict = snapshot.value as! [String : AnyObject]
            var sendAnswerData = [AnswerC]()
            var sendTally = 0;
            var sendIsCorrect = false;
            var sendAnswerText = "";
            for (AID, data) in postDict {
                if (selectedAnswerIDs.contains(AID)) {
                    let information = data as! [String : AnyObject]
                    
                    for (key,value) in information {
                        if (key == "answer") {
                            sendAnswerText = value as! String ;
                        }
                        if (key == "isCorrect") {
                            sendIsCorrect = value as! Bool
                        }
                        if (key == "tally") {
                            sendTally = Int(value as! String)!
                        }
                        
                    }
                    
                    let tempAnswer = AnswerC(AID: AID, isCorrect: sendIsCorrect, tally: sendTally, answerText: sendAnswerText)
                    sendAnswerData.append(tempAnswer)
                    
                }
            }
            
            completionHandler(listofAllAnswers: sendAnswerData)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func setCorrectAnswer(answerId: AnswerID, isCorrectAnswer: Bool) -> Bool {
        let fBD:FirebaseData = FirebaseData();
        fBD.updateFirebaseDatabase("ANSWERS/AIDS/\(answerId as String)", targetNode: "isCorrect", desiredValue: isCorrectAnswer)
        
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
    
    //    func getAnswer(answerId: AnswerID) -> String {
    //        return "This is the answer"
    //    }
    //
    //    func getListOfAnswerIDs(questionId: QuestionID) -> [AnswerID] {
    //        return ["A1","A2","A3","A4"]
    //    }
    
    func getSumOfUsersThatSubmittedAnswers(questionID: QuestionID) -> Int {
        return 40
    }
    
    func getNumberOfUsersThatGaveThisAnswer(questionID: QuestionID, answerID: AnswerID) -> Int {
        
        return 10
    }
    
}
