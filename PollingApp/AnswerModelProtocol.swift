//
//  AnswerModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

protocol AnswerModelProtocol {
  
  //MARK: Setting Answer Information -
  func setNewAnswer(answer: String, questionID: QuestionID) -> AnswerID
  func setCorrectAnswer(answerId: AnswerID, isCorrectAnswer: Bool) -> Bool
  func setUserAnswer(questionId: QuestionID, answerID: AnswerID) -> Bool
  
  
  //MARK: - Get Answer Information -
  func isCorrectAnswer(answerId: AnswerID) -> Bool
  func getCorrectAnswer(questionID: QuestionID) -> AnswerID
  func getAnswer(answerId: AnswerID) -> String
  func getListOfAnswerIDs(questionId: QuestionID) -> [AnswerID]
  func getSumOfUsersThatSubmittedAnswers(questionId: QuestionID) -> Int
  func getNumberOfUsersThatGaveThisAnswer(questionID: QuestionID,answerID:AnswerID) -> Int
}
