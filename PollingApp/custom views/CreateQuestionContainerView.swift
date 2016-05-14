//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  
  func submitButtonPressed(question: Question, answerArray: [String])
  func backButtonPressed()
 
}


class CreateQuestionContainerView: UIView {
  
    
    
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
    var delegate: CreateQuestionViewContainerDelegate?
  
    @IBOutlet weak var questionInputText: UITextField!
    
    @IBOutlet weak var Ans1: UITextField!
    
    @IBOutlet weak var Ans2: UITextField!
    
    @IBOutlet weak var Ans3: UITextField!
    
    @IBOutlet weak var Ans4: UITextField!
    
    
  @IBAction func SubmitPress(sender: AnyObject) {
    var question = questionInputText.text;
    var Answers = [Ans1.text!, Ans2.text!, Ans3.text!, Ans4.text!];

    delegate?.submitButtonPressed(question!,answerArray: Answers);
    
      
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


