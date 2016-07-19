//
//  InputNameView.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-07-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit

protocol InputNameViewDelegate {
  func displayConfirmationMessage (name: String)
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

  @IBAction func submitButtonPressed(sender: AnyObject) {
    let name = inputNameTextField.text
    delegate?.displayConfirmationMessage(name!)
  }
  
}




