//
//  TimerUtil.swift
//  PollingApp
//
//  Created by Odin on 2016-07-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class TimerUtil {
  static let secondsInADay = 86400
  static let secondsInAnHour = 3600
  static let secondsInAMinute = 60
  
  static func totalSecondsToString(sec: Int) -> String {
    return sec < secondsInADay
      ? formatSecondsToHHMMSS(sec)
      : formatSecondsToDays(sec)
  }

  static func formatSecondsToDays(sec: Int) -> String {
    let numberOfDays = sec/secondsInADay
    
    if sec < secondsInADay {
      return UIStringConstants.lessThanOneDayLeft
    }
    
    if numberOfDays <= 1 {
      return "\(numberOfDays) Day Left"
    } else {
      return "\(numberOfDays) Days Left"
    }
  }

  static func formatSecondsToHHMMSS(sec: Int) -> String {
    let hours = sec/secondsInAnHour
    let minutes = (sec - hours*secondsInAnHour) / secondsInAMinute
    let seconds = sec - hours*secondsInAnHour - minutes*secondsInAMinute
    
    if sec < secondsInAMinute {
      let secondsString = setLeadingZero(seconds)
      return "00:00:\(secondsString)"
    } else if sec < secondsInAnHour {
      let minutesString = setLeadingZero(minutes)
      let secondsString = setLeadingZero(seconds)
      return "00:\(minutesString):\(secondsString)"
    } else {
      let hoursString = setLeadingZero(hours)
      let minutesString = setLeadingZero(minutes)
      let secondsString = setLeadingZero(seconds)
      return "\(hoursString):\(minutesString):\(secondsString)"
    }
  }
  
  static private func setLeadingZero(num: Int) -> String {
    if num < 10 {
      return "0\(num)"
    } else {
      return "\(num)"
    }
  }

}

