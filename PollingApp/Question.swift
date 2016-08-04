//
//  QuestionC.swift
//
//
//  Created by James Park on 2016-06-14.
//
//

import Foundation

public class Question: NSObject {
  
  var QID = ""
  var AIDS = [AnswerID]()
  var author = ""
  var questionText = ""
  var endTimestamp = 0.0
  var isExpired = false
  var expireMessage = ""
  
  override init() {
  }
  
  init (QID: String, AIDS:[AnswerID], author:String, questionText:QuestionText, endTimestamp:Double) {
    self.QID = QID
    self.AIDS = AIDS
    self.author = author
    self.questionText = questionText
    self.endTimestamp = endTimestamp
  }
  
  override public func isEqual(object: AnyObject?) -> Bool {
    if let object = object as? Question {
      return QID == object.QID
    } else {
      return false
    }
  }
  
  override public var hash: Int {
    return QID.hashValue
  }
}


