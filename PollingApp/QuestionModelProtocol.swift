//
//  QuestionModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

protocol QuestionModelProtocol {
  
  //MARK: - Setting Question Information -
  func setNewQuestion(question: String) -> Bool
  
  //MARK: - Getting Question Information -
  func getQuestion(questionId: QuestionID) -> String
  func getQuestionID() -> QuestionID
  func getListOfQuestions() -> [QuestionID]
  func getListOfQuestionsUserCreated() -> [QuestionID]
  func isQuestionAnswered(questionId: QuestionID) -> Bool
  
  //MARK: - Remove Question Information -
  func removeQuestion(questionId: QuestionID) -> Bool
  
  //MARK: - Segues -
  func segueToQuestionsUserCreated() -> SegueName
  func segueToQuestionsNearMe() -> SegueName
  func segueToQuestion() -> SegueName
  func segueToCreateNewQuestion() -> SegueName
  func segueToQuestionsScreen() -> SegueName
}
