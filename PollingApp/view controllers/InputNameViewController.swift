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
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(InputNameViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        nameTextField.delegate = self
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        submitButton()
    }
    func submitButton () {
        checkChars()
        
        if ModelInterface.sharedInstance.isValidName(nameTextField.text!) == false {
            let alert = UIAlertController(title: "Invalid name", message:"",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok",
                style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        let udid = UIDevice.currentDevice().identifierForVendor?.UUIDString
        
        FIRAuth.auth()?.createUserWithEmail("\(nameTextField.text!)@ubclaunchpad.com", password: udid!) { (user, error) in
            if error != nil {
                print("User name is taken")
            }
        }
        currentUser = nameTextField.text!
        let segueName = ModelInterface.sharedInstance.setUserName(nameTextField.text!)
        performSegueWithIdentifier(segueName, sender: self)
    }
    // MARK: - Helper methods
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate -
extension InputNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        submitButton()
        return false
    }
    
    func checkChars() { //TODO: move this into a utils classs.
        if nameTextField.text?.characters.count == 0 {
            let alert = UIAlertController(title: "Please enter your name", message:"", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}

