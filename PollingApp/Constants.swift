//
//  Constants.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation


typealias QuestionID = String
typealias RoomID = String
typealias AnswerID = String
typealias SegueName = String

var selectedQuestion = Question();

var okayNameCharacters : Set<Character> =
Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)

enum UserDefaultKeys {
  static let userName = "username"
}

enum Segues {
  static let toMainApp = "showMainApp"
  static let toSomeVC = "myIdentifier"
  static let toQuestionsScreen = "toQuestionsScreen"
  static let toPollUserViewController = "toPollUserViewController"
  static let toCreateQuestionView = "toCreateQuestionView"
  static let toPollAdminScreen = "toPollAdminScreen"
  static let toPollResultsView = "toPollResultsView"
}
 
