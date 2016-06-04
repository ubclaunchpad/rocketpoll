//
//  FirebaseData.swift
//  PollingApp
//
//  Created by QuantumSpark and Cyrus on 2016-02-20.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import Firebase

// Singleton Class
// Note  add references to other nodes if needed

class FirebaseData {
  
  
  func postToFirebase (keyBool:Bool, parent:String, child:String, children:NSDictionary) {
    let ref =  FIRDatabase.database().reference();
    var key:String
    
    if (keyBool) {
      key = ref.child(child).childByAutoId().key
    }
    else {
      key = child
    }
    
    let childUpdates = ["/" + parent + "/\(key)": children];
    ref.updateChildValues(childUpdates)
    
  }
  
    
    
    
}
