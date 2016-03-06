//
//  TimerModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-05.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

extension ModelInterface: TimerModelProtocol {
  
  func stopTimer(questionID: QuestionID) -> Bool {
    return true
  }
  
  func getCountdownSeconds() -> Int {
    return 70
  }
  
  func setTimerSeconds(seconds : Int) -> Bool {
    return true
  }
  

}
