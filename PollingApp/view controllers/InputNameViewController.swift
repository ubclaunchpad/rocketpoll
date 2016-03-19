//
//  InputNameViewController.swift
//  PollingApp
//
//  Created by Jon Mercer on 2/6/16.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import UIKit


class InputNameViewController: UIViewController, UITextFieldDelegate {
    
    
    // Submit name using Enter key
    override func viewDidLoad(){
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        checkChars()
        saveUser()
        performSegueWithIdentifier(Segues.toMainApp, sender: self)

        return true
    }
    
    

  @IBOutlet weak var nameTextField: UITextField!

  // MARK: - Actions
  @IBAction func submitButtonPressed(sender: AnyObject) {
    // TODO: Check for Nil value, if Nil present UIAlertView otherwise continue

    checkChars()
    
    saveUser()
    performSegueWithIdentifier(Segues.toMainApp, sender: self)
    
  }
  
  @IBAction func submitButtonPressed(sender: AnyObject) {
    
    //TODO:warn users to not use special characters instead of just stripping it
    let cleanedName = cleanName(nameTextField.text!)
    
    if(cleanedName.characters.count <= 0) {
      let alert = UIAlertController(title: "Invalid name", message:"",
        preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok",
        style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return
    }
    
    assert(cleanedName.characters.count != 0 , "Name cannot be blank")
    
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
    
    func checkChars() {
        if(nameTextField.text?.characters.count == 0) {
            print("DEBUG", "nameTextField.text = <empty>")
            let alert = UIAlertController(title: "Please enter your name", message:"", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

        }
    }
    
    func noName() {
        nameTextField.resignFirstResponder()
        let alert = UIAlertController(title: "Please enter your name", message:"", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated:true, completion: nil)

    }
    
}

