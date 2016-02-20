//
//  InputNameViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class InputNameViewController: UIViewController {
  @IBOutlet weak var nameTextField: UITextField!
  
  // MARK: - Actions
  @IBAction func submitButtonPressed(sender: AnyObject) {
    // TODO: Check for Nil value, if Nil present UIAlertView otherwise continue
    saveUser()
    performSegueWithIdentifier(Segues.toSomeVC, sender: self)
    
  }
  
  // MARK: - Delegate methods
  // TODO: Add delegate method for did end text editing to do an automatic segue to FirstViewController
  // TODO: Add delegate method for return to hide keyboard
  
  
  // MARK: - Helper methods
  
  func saveUser() {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let userName = nameTextField.text
    userDefaults.setValue(userName, forKey: UserDefaultKeys.userName)
    print(userName) 
  }
}
