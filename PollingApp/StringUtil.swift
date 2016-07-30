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
  
  
  static func randomStringWithLength (len : Int) -> NSString {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    let randomString : NSMutableString = NSMutableString(capacity: len)
    
    for (var i=0; i < len; i++){
      let length = UInt32 (letters.length)
      let rand = arc4random_uniform(length)
      randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString
  }
}