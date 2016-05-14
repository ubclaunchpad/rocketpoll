//
//  QuestionModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

extension ModelInterface: QuestionModelProtocol {
  
  //MARK: - Setting Question Information -
  func setNewQuestion(question: String) -> Bool {
    return true
  }
  
  //MARK: - Getting Question Information -
  func getQuestion(questionId: QuestionID) -> String {
    return "Is this a question?"
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
