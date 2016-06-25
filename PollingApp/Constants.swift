//
//  Constants.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation


typealias QuestionID = String
typealias QuestionText = String
typealias AnswerID = String
typealias AnswerText = String

typealias Author = String 
typealias SegueName = String
typealias RoomID = String
var selectedQuestion = Question();

var currentUser:Author = "";

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
  static let toPollAdminVCFromCampaign = "toPollAdminVCFromCampaign"
    
}
 
