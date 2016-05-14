//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  func submitButtonPressed()
  func backButtonPressed()
 
}


class CreateQuestionContainerView: UIView {
  
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
    var delegate: CreateQuestionViewContainerDelegate?
  
  @IBAction func SubmitPress(sender: AnyObject) {
    delegate?.submitButtonPressed();
    
      
  }
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.backButtonPressed()
  }
  
  
    class func instanceFromNib(frame: CGRect) -> CreateQuestionContainerView {
        let view = UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CreateQuestionContainerView
        view.frame = frame
        return view
    }


}


