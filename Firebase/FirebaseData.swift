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
  
  
  func postToFirebaseWithKey ( parent:String, child:String, children:NSDictionary) -> String {
    let ref =  FIRDatabase.database().reference();

    let key = ref.child(child).childByAutoId().key
    
    
    let childUpdates = ["/" + parent + "/\(key)": children];
    ref.updateChildValues(childUpdates)
    
    return key;
  }
  
    
}
