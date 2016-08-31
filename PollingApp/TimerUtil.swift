//
//  TimerUtil.swift
//  PollingApp
//
//  Created by Odin on 2016-07-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class TimerUtil {
  static let secondsInADay = UITimeConstants.oneDayinSeconds
  static let secondsInAnHour = UITimeConstants.oneHourinSeconds
  static let secondsInAMinute = UITimeConstants.oneMinuteinSeconds
  
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
      return "\(StringUtil.fillInString(UITimeRemaining.endsDay, time: numberOfDays))"
    } else {
      return "\(StringUtil.fillInString(UITimeRemaining.endsDays, time: numberOfDays))"
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
  
  static func getHourValueFromDurationInSeconds(seconds: Int) -> Int {
    //Int(3.99) = 3
    return Int(seconds/UITimeConstants.oneHourinSeconds)
  }
  
  static func getMinuteValueFromDurationInSeconds(seconds: Int) -> Int {
    //Int(3.99) = 3
    return Int((seconds%UITimeConstants.oneHourinSeconds)/UITimeConstants.oneMinuteinSeconds)
  }
  
  static func getTextToShowInTimer(seconds: Int) -> String {
    let hour: Int = TimerUtil.getHourValueFromDurationInSeconds(seconds)
    let min: Int = TimerUtil.getMinuteValueFromDurationInSeconds(seconds)
    
    var minString:String
    if(min <= 1) {
      minString = "\(StringUtil.fillInString(UITimeRemaining.timerMinute, time: min))"
    } else {
      minString = "\(StringUtil.fillInString(UITimeRemaining.timerMinutes, time: min))"
    }
    
    var hourString:String
    if(hour <= 1) {
      hourString = "\(StringUtil.fillInString(UITimeRemaining.timerHour, time: hour))"
    } else {
      hourString = "\(StringUtil.fillInString(UITimeRemaining.timerHours, time: hour))"
    }
    
    return hour == 0 ? minString : hourString + ", " + minString
  }
}

