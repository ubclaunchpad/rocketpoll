//
//  InputNameView.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-07-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit

protocol InputNameViewDelegate {
  func submit (name: String)
  func sendTextField(inputNameTextField: UITextField)
}

class InputNameView: UIView {
  
  
 
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet weak var inputNameTextField: UITextField!
  
  var delegate: InputNameViewDelegate?
  
  class func instanceFromNib(frame: CGRect) -> InputNameView {
    let view = UINib(nibName: "InputNameView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! InputNameView
    view.frame = frame
    return view
  }
  @IBAction func textFieldPressed(sender: AnyObject) {
  delegate?.sendTextField(inputNameTextField)
  }

  @IBAction func submitButtonPressed(sender: AnyObject) {
    let name = inputNameTextField.text
    delegate?.submit(name!)
    
  }
  
}




