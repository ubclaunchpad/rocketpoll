//
//  AnswerModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

extension ModelInterface: AnswerModelProtocol {
  
  //MARK: Setting Answer Information -
  func setNewAnswer(answer: String, questionID: QuestionID) -> AnswerID {
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
  
  func getNumberOfUsersThatGaveThisAnswer(questionID: QuestionID) -> Int {
    return 10
  }
}
