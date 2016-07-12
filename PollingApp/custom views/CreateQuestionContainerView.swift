//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  
  func submitButtonPressed(question: QuestionText, answerArray: [AnswerText])
  func backButtonPressed()
  func checksInput (question:QuestionText, A1:AnswerText, A2:AnswerText, A3:AnswerText, A4:AnswerText) -> Bool
}

class CreateQuestionContainerView: UIView {
  @IBOutlet weak var timerLabel: UILabel!
  
  @IBOutlet weak var setTimerButton: UIButton!
  
  @IBOutlet weak var timerScroller: UIDatePicker!
  
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
  var delegate: CreateQuestionViewContainerDelegate?
  
  @IBOutlet weak var questionInputText: UITextField!
  
  @IBOutlet weak var Ans1: UITextField!
  
  @IBOutlet weak var Ans2: UITextField!
  
  @IBOutlet weak var Ans3: UITextField!
  
  @IBOutlet weak var Ans4: UITextField!
  
  @IBAction func setTimerButtonPressed(sender: AnyObject) {
    timerScroller.alpha = 1;
  }
  
  @IBAction func SubmitPress(sender: AnyObject) {
    
    let question = questionInputText.text;
    let A1 = Ans1.text;
    let A2 = Ans2.text;
    let A3 = Ans3.text;
    let A4 = Ans4.text;
    
    if ((  delegate?.checksInput(question!, A1: A1!, A2: A2!, A3: A3!, A4: A4!)) == true) {
      return
    }
    
    let Answers = [A1!, A2!, A3!, A4!];
    
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


