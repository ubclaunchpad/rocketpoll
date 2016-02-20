//
//  RoomViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
//import Firebase

class RoomViewContainer: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var roomName: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "RoomViewContainer", bundle: nil).instantiateWithOwner(self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
    
    /* TODO: uncomment after firebase is sorted out
    @IBAction func submitButton() {
        // Read data and react to changes
        let firebaseRef = Firebase(url: "https://polling-app-test.firebaseio.com/")
        firebaseRef.observeEventType(.Value, withBlock: {
            snapshot in
            println("\(snapshot.key) -> \(snapshot.value)")
        })
        
        
        // TODO: instantiate next xib
        print("Submit button pressed\n")
    }*/
    
}
