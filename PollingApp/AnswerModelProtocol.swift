//
//  AnswerModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

protocol AnswerModelProtocol {
    
    
    func setAnswerIDS(questionID:QuestionID, answerText:[AnswerText]) -> [String]
    //MARK: Setting Answer Information -
    func setCorrectAnswer(answerId: AnswerID, isCorrectAnswer: Bool) -> Bool
    func setUserAnswer(questionId: QuestionID, answerID: AnswerID) -> Bool
    func processAnswerData(selectedAnswerIDs:[AnswerID],completionHandler: (listofAllAnswers: [Answer]) -> ())
    
    //Mark: Helper Methods - 
    func parseAIDNodeAndItsChildren(data:NSDictionary, selectedAnswerIDs:[AnswerID]) -> [Answer]
    func parseAnswerNodeInformation(data:NSDictionary, AID: AnswerID) -> Answer
    
    //MARK: - Get Answer Information -
    func isCorrectAnswer(answerId: AnswerID) -> Bool
    func getCorrectAnswer(questionID: QuestionID) -> AnswerID
    func getSumOfUsersThatSubmittedAnswers(questionId: QuestionID) -> Int
    func getNumberOfUsersThatGaveThisAnswer(questionID: QuestionID, answerID:AnswerID) -> Int
    
}
