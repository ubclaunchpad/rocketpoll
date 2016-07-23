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
}
