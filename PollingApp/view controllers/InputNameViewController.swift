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
        nameTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(InputNameViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        checkChars()
        performSegueWithIdentifier(Segues.toMainApp, sender: self)
        
        //TODO:warn users to not use special characters instead of just stripping it
        let cleanedName = cleanName(nameTextField.text!)
        
        if(cleanedName.characters.count <= 0) {
            let alert = UIAlertController(title: "Invalid name", message:"",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok",
                style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        assert(cleanedName.characters.count != 0 , "Name cannot be blank")
        
        let udid = UIDevice.currentDevice().identifierForVendor?.UUIDString
        
        FIRAuth.auth()?.createUserWithEmail("\(cleanedName)@ubclaunchpad.com", password: udid!) { (user, error) in
            if error != nil {
                print("User name is taken")
            }
        }
        currentUser = cleanedName
        let segueName = ModelInterface.sharedInstance.setUserName(cleanedName)
        performSegueWithIdentifier(segueName, sender: self)
    }
    
    // MARK: - Helper methods
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //TODO: move this to the model layer. Possibly in a utils class?
    func cleanName(name: String) -> String {
        let strippedString = String(
            name.characters.filter {okayNameCharacters.contains($0)})
        let trimmedString = strippedString.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceCharacterSet())
        return trimmedString
    }
    
}

// MARK: - UITextFieldDelegate -
extension InputNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        checkChars()
        performSegueWithIdentifier(Segues.toMainApp, sender: self)
        let cleanedName = cleanName(nameTextField.text!)
        if(cleanedName.characters.count <= 0) {
            let alert = UIAlertController(title: "Invalid name", message:"",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok",
                style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return true
        }
        //print("testing");
        textField.resignFirstResponder()
        
        assert(cleanedName.characters.count != 0 , "Name cannot be blank")
        
        let segueName = ModelInterface.sharedInstance.setUserName(cleanedName)
        performSegueWithIdentifier(segueName, sender: self)
        
        return false
    }
    
    func checkChars() {
        if(nameTextField.text?.characters.count == 0) {
           // print("DEBUG", "nameTextField.text = <empty>")
            let alert = UIAlertController(title: "Please enter your name", message:"", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
}

