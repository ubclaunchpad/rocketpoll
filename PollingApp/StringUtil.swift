//
//  StringUtil.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class StringUtil {
  static func fillInString(message: String, time: Int) -> String {
    let returnString = message.stringByReplacingOccurrencesOfString("%1%", withString:  "\(time)")
    return returnString
  }
  
  static func fillInString(message: String, time: Int, date: String) -> String {
    let tempString = message.stringByReplacingOccurrencesOfString("%1%", withString:  "\(time)")
    let returnString = tempString.stringByReplacingOccurrencesOfString("%2%", withString: "\(date)")
    return returnString
  }
  
  static func fillInString(message: String, time1: Int, time2: Int, date:String) -> String {
    let tempString = message.stringByReplacingOccurrencesOfString("%1%", withString:  "\(time1)")
    let tempString2 = tempString.stringByReplacingOccurrencesOfString("%2%", withString: "\(time2)")
    let returnString = tempString2.stringByReplacingOccurrencesOfString("%3%", withString: "\(date)")
    return returnString
  }
  
  static func cleanNameText(name: String) -> String {
    let strippedString = String(
      name.characters.filter {okayNameCharacters.contains($0)})
    let trimmedString = strippedString.stringByTrimmingCharactersInSet(
      NSCharacterSet.whitespaceCharacterSet())
    return trimmedString
  }
  
  static func cleanText(name: String) -> String {
    var strippedString = name.stringByReplacingOccurrencesOfString("\(charactersToAvoid[0])", withString: "")
    for index in 0...(charactersToAvoid.count - 1) {
      strippedString = strippedString.stringByReplacingOccurrencesOfString("\(charactersToAvoid[index])", withString: "")
    }
    let trimmedString = strippedString.stringByTrimmingCharactersInSet(
      NSCharacterSet.whitespaceCharacterSet())
    return trimmedString
  }
  
  static func trimString(text: String) -> String {
    let trimmedString = text.stringByTrimmingCharactersInSet(
      NSCharacterSet.whitespaceCharacterSet())
    return trimmedString
  }
  
  static func uniqueString(texts: [String]) -> Bool {
    var uniqueStrings = Set<String>()
    for text in texts {
      uniqueStrings.insert(text)
    }
    return texts.count == uniqueStrings.count
  }
}