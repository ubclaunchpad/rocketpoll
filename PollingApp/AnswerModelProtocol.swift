//
//  AnswerModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

protocol AnswerModelProtocol {
  
  
  func createAnswerIDs(questionID:QuestionID, answerText:[AnswerText]) -> [String]
  //MARK: Setting Answer Information -
  func setCorrectAnswer(answerId: AnswerID, isCorrectAnswer: Bool) -> Bool
  func setUserAnswer (answerID: AnswerID, increase:Bool) -> Bool
  func processAnswerData(selectedAnswerIDs:[AnswerID],completionHandler: (listofAllAnswers: [Answer]) -> ())
  
  func rememberAnswer (questionID:QuestionID, answerID:AnswerID, completionHandler : (DontAllowRevoting: Bool) -> ())
  
  func findYourAnswer(questionID:QuestionID,completionHandler: (yourAnswer:AnswerID) -> ())
  
  //Mark: Helper Methods -
  func parseAIDNodeAndItsChildren(data:NSDictionary, selectedAnswerIDs:[AnswerID]) -> [Answer]
  func parseAnswerNodeInformation(data:NSDictionary, AID: AnswerID) -> Answer
  
  //MARK: - Get Answer Information -
  func isCorrectAnswer(answerId: AnswerID) -> Bool
  func getCorrectAnswer(questionID: QuestionID) -> AnswerID
}
