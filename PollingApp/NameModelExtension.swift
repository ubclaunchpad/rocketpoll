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
  func setUserName(name: String) -> SegueName {
    let ref =  FIRDatabase.database().reference();
    let udid = UIDevice.currentDevice().identifierForVendor!.UUIDString
    let post = ["UserName": name,
                "MyQuestions": "my questions",
                "QuestionsAnswered":  "questions answered"];
    let childUpdates = ["/users/\(udid)": post]

    ref.updateChildValues(childUpdates)

    return Segues.toMainApp
  }
}
