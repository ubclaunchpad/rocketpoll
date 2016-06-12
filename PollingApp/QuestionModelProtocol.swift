//
//  QuestionModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation
import Firebase
protocol QuestionModelProtocol {
  
  //MARK: - Setting Question Information -
  func setNewQuestion(question: String) -> QuestionID
  
  //MARK: - Getting Question Information -
    
  func getQuestion(questionId: QuestionID, snapshot:FIRDataSnapshot) -> String
  func getSelectedQuestionID() -> QuestionID
    func setSelectedQuestionID(questionID:String);
  func getListOfQuestions(snapshot:FIRDataSnapshot) -> [QuestionID]
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
  func segueToAdminScreen() -> SegueName
  func segueToResultsScreen() -> SegueName
}
