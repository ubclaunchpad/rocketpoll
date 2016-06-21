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
    
    func postToFirebaseWithOutKey (parent: String, child:String, children: NSDictionary) {
        let ref =  FIRDatabase.database().reference();
        
        let childUpdates =  ["/" + parent + "/\(child)": children];
        ref.updateChildValues(childUpdates)
    }
    
    func updateFirebaseDatabase (parent: String, targetNode:String, desiredValue:NSObject) {
        let ref =  FIRDatabase.database().reference();

        ref.child("\(parent)/\(targetNode)").setValue(desiredValue);
    }


}
