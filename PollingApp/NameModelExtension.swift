//
//  NameModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation
import Firebase

extension ModelInterface: NameModelProtocol {
  
  // TODO: Check if udid exists
  func setUserName(name: String, userID: String) {
    
    let ref =  FIRDatabase.database().reference();
    
    let udid = UIDevice.currentDevice().identifierForVendor!.UUIDString
    
    ref.queryEqualToValue(udid)
    
    let post = ["UserName": name,
                "ListOfQuestion": "",
                "QuestionsAnswered": ""];
    let childUpdates = ["/Users/\(userID)": post]
    
    ref.updateChildValues(childUpdates)

  }
  
  func cleanName(name: String) -> String {
    let strippedString = String(
      name.characters.filter {okayNameCharacters.contains($0)})
    let trimmedString = strippedString.stringByTrimmingCharactersInSet(
      NSCharacterSet.whitespaceCharacterSet())
    return trimmedString
  }
  
  func isValidName(name:String) -> Bool {
    for char in name.characters {
      if (!okayNameCharacters.contains(char)) {
        return false
      }
    }
    return true
  }
  
}
