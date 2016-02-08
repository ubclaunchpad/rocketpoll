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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
  }
  
  // MARK: - Actions
  @IBAction func submitButtonPressed(sender: AnyObject) {
    if(nameTextField.text?.characters.count <= 0) {
      print("DEBUG", "nameTextField.text = <empty>")
      let alert = UIAlertController(title: "Please add a name", message:"", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return
    }
    
    saveUser()
    performSegueWithIdentifier(Segues.toMainApp, sender: self)
  }
  
  // MARK: - Helper methods
  
  func saveUser() {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    assert(nameTextField.text?.characters.count != 0 , "Name cannot be blank")
    let userName = nameTextField.text
    userDefaults.setValue(userName, forKey: UserDefaultKeys.userName)
    userDefaults.synchronize()
    print("DEBUG","userName = ", userName!)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
}

// MARK: - UITextFieldDelegate
extension InputNameViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if(nameTextField.text?.characters.count <= 0) {
      print("DEBUG", "nameTextField.text = <empty>")
      let alert = UIAlertController(title: "Please add a name", message:"", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      
      return true
    }
    
    textField.resignFirstResponder()
    saveUser()
    performSegueWithIdentifier(Segues.toMainApp, sender: self)
    
    return false
  }
}
