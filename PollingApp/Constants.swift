//
//  Constants.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

typealias Question = String
typealias QuestionID = String
typealias RoomID = String
typealias AnswerID = String
typealias SegueName = String

enum UserDefaultKeys {
  static let userName = "username"
}

enum Segues {
  static let toMainApp = "showMainApp"
  static let toSomeVC = "myIdentifier"
}
 
