//
//  FirebaseData.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-02-20.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import Firebase

// Singleton Class
// Note  add references to other nodes if needed
let mainurl = "https://polling-app-test.firebaseio.com"

class FirebaseData {
    
    static let fd = FirebaseData();

    // Main reference
    private var _base_ref = Firebase(url:"\(mainurl)")
    
    // Test reference
    private var _test_ref = Firebase(url:"\(mainurl)/ON_OFF");
    
    
    var base_ref: Firebase {
        return _base_ref
    }
    
    var test_ref: Firebase {
        return _test_ref;
    }
    
    
    
    
}
