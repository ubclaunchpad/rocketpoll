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
    
    if(nameTextField.text?.characters.count <= 0) {
      print("name is nil")
      let alert = UIAlertController(title: "Please add a name", message:"", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return
    }
    
    saveUser()
    performSegueWithIdentifier(Segues.toMainApp, sender: self)
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

extension InputNameViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    //TODO: Check for nil and remove code duplication
    textField.resignFirstResponder()
    saveUser()
    performSegueWithIdentifier(Segues.toMainApp, sender: self)
    
    return false
  }
}
