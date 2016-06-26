//
//  TimerModelExtension.swift
//  PollingApp
//
//  Created by Jon on 2016-03-05.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation
import Firebase

extension ModelInterface: TimerModelProtocol {
  
  func stopTimer(questionID: QuestionID) {
    let ref = FIRDatabase.database().reference()
    let currentTime = NSDate().timeIntervalSince1970
    ref.child("QUESTIONSCREEN/\(questionID)/endTimeStamp").setValue(currentTime)
  }
  
  func getCountdownSeconds(QID: QuestionID, completion: (Int) -> Void) {
    let timerRef = FIRDatabase.database().reference().child("QUESTIONSCREEN/\(QID)")
    timerRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
        let timeDict = snapshot.value as! [String : AnyObject]
        // ...
        print(timeDict)
        completion(timeDict["endTimeStamp"] as! Int)
    })
    
    
  }
  
  func setTimerSeconds(seconds : Int) -> Bool {
    return true
  }
  

}
