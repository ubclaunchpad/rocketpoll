//
//  QuestionC.swift
//
//
//  Created by James Park on 2016-06-14.
//
//

import Foundation

class Question {
  
  var QID = ""
  var AIDS = [AnswerID]()
  var author = ""
  var questionText = ""
  var endTimestamp = 0.0
  var isExpired = false
  var expireMessage = ""
  
  init() {
  }
  
  init (QID: String, AIDS:[AnswerID], author:String, questionText:QuestionText, endTimestamp:Double) {
    self.QID = QID
    self.AIDS = AIDS
    self.author = author
    self.questionText = questionText
    self.endTimestamp = endTimestamp
  }
  
}