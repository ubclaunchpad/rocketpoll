//
//  InputNameViewController.swift
//  PollingApp
//
//  Created by Jon Mercer on 2/6/16.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import UIKit
import FirebaseAuth

class InputNameViewController: UIViewController {
  var container: InputNameView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(InputNameViewController.dismissKeyboard))
    
    view.addGestureRecognizer(tap)
    
    addContainerToVC()
    
  }
  
  func checkChars(name: String) { //TODO: move this into a utils classs.
    if name.characters.count == 0 {
      let alert = UIAlertController(title: "\(alertMessages.empty)", message:"", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  func addContainerToVC() {
    container = InputNameView.instanceFromNib(
      CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    container?.delegate = self
    view.addSubview(container!)
  }

  // MARK: - Helper methods
  func dismissKeyboard() {
    view.endEditing(true)
  }
}

// MARK: - InputeNameView Delegate -


extension InputNameViewController: InputNameViewDelegate {
  
  func sendTextField(inputNameTextField: UITextField) {
    inputNameTextField.delegate = container
  }
  
  func submit (name: String){
    checkChars(name)
    
    if ModelInterface.sharedInstance.isValidName(name) == false {
      let alert = UIAlertController(title: "\(alertMessages.invalid)", message:"",
                                    preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)",
        style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      
    }
    
    let udid = UIDevice.currentDevice().identifierForVendor?.UUIDString
    
    FIRAuth.auth()?.createUserWithEmail("\(name)\(launchpadEmail)", password: udid!) { (user, error) in
      if error != nil {
        print("User name is taken")
      }
    }
    currentUser = name
    let segueName = ModelInterface.sharedInstance.setUserName(name)
    performSegueWithIdentifier(segueName, sender: self)
  }
}

extension InputNameView: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    let name = inputNameTextField.text
    delegate?.submit(name!)
    return false
  }
}
