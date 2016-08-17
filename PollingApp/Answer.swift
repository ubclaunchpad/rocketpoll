//
//  AnswerC.swift
//  PollingApp
//
//  Created by James Park on 2016-06-14.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation


class Answer {
  var AID:AnswerID = ""
  var answerText:AnswerText = ""
  var isCorrect = false
  var tally = 0
  var listOfUsers:[Author] = []
  
  init (AID:AnswerID, isCorrect:Bool, tally:Int, answerText:AnswerText) {
    self.AID = AID
    self.isCorrect = isCorrect
    self.tally  = tally
    self.answerText = answerText
  }
}