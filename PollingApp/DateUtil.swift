//
//  DateUtil.swift
//  PollingApp
//
//  Created by Odin on 2016-07-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

extension NSDate {
  
  func hour() -> Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Hour, fromDate: self)
    let hour = components.hour
    return hour
  }
  
  
  func minute() -> Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Minute, fromDate: self)
    let minute = components.minute
    return minute
  }
  
  func timeStamp() -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "HH:mm:ss.SSS"
    return formatter.stringFromDate(self)
  }
  
  func timeStampAMPM() -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "h:mm a"
    formatter.AMSymbol = "AM"
    formatter.PMSymbol = "PM"
    
    return formatter.stringFromDate(self)
  }
  
  func detailedTimeStamp() -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "h:mm a 'on' EEEE, MMM d"
    formatter.AMSymbol = "AM"
    formatter.PMSymbol = "PM"
    
    
    return formatter.stringFromDate(self)
  }
}

class DateUtil {
  
  static func findDateState(day:Int, hour:Int, minute:Int) -> [Bool] {
    return [day == 1, hour == 1, minute == 1]
  }
  
  static  func setExpirationDate (question:Question) -> Question {
    
    let currentTime = Int(NSDate().timeIntervalSince1970)
    let difference = currentTime - Int(question.endTimestamp)
    let absDifference = abs(difference)
    
    if absDifference < UITimeConstants.moment {
      if difference > 0 {
        question.isExpired = true
        question.expireMessage = UITimeRemaining.endedMoments
      } else {
        question.isExpired = false
        question.expireMessage = UITimeRemaining.endsMoments
      }
    }
    else if absDifference < UITimeConstants.oneHourinSeconds {
      let minutes = absDifference/UITimeConstants.oneMinuteinSeconds
      if difference > 0 {
        question.isExpired = true
        question.expireMessage = StringUtil.fillInString(UITimeRemaining.endedMinutes, time: minutes)
      } else {
        question.isExpired = false
        question.expireMessage = StringUtil.fillInString(UITimeRemaining.endsMinutes, time: minutes)
      }
    }
    else if absDifference < UITimeConstants.oneDayinSeconds {
      let hours = Int(absDifference/UITimeConstants.oneHourinSeconds)
      if difference > 0 {
        question.isExpired = true
        if hours > 1 {
          question.expireMessage = StringUtil.fillInString(UITimeRemaining.endedHours, time: hours)
        } else {
          question.expireMessage = StringUtil.fillInString(UITimeRemaining.endedHour, time: hours)
        }
      } else {
        question.isExpired = false
        if hours > 1 {
          question.expireMessage = StringUtil.fillInString(UITimeRemaining.endsHours, time: hours)
        } else {
          question.expireMessage = StringUtil.fillInString(UITimeRemaining.endsHour, time: hours)
        }
      }
    }
    else {
      let days = Int(absDifference/UITimeConstants.oneDayinSeconds)
      if difference > 0 {
        ModelInterface.sharedInstance.removeQuestion(question.QID)
        let AIDS = question.AIDS
        for i in 0...AIDS.count {
          ModelInterface.sharedInstance.removeAnswer(AIDS[i])
        }
        
      } else {
        question.isExpired = false
        if days > 1 {
          question.expireMessage = StringUtil.fillInString(UITimeRemaining.endsDays, time: days)
        } else {
          question.expireMessage = StringUtil.fillInString(UITimeRemaining.endsDay, time: days)
        }
      }
    }
    
    return question
  }
  
  
}
