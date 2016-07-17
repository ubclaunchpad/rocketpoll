//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  
  func submitButtonPressed(question: QuestionText, answerArray: [AnswerText], questionDuration: Int)
  func backButtonPressed()
  func checksInput(question:QuestionText, A1:AnswerText, A2:AnswerText, A3:AnswerText, A4:AnswerText, timerWasSet:Bool) -> Bool
}

class CreateQuestionContainerView: UIView {
  @IBOutlet weak var timerLabel: UILabel!
  
  @IBOutlet weak var doneButton: UIButton!
  
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
  
  @IBOutlet weak var tableView: UITableView!
  
  var timerHasBeenSet = false
  
  var time: Int = 0;
  
  @IBAction func setTimerButtonPressed(sender: AnyObject) {
    doneButton.alpha = 1;
    Submit.alpha = 0
    setTimerButton.alpha = 0;
    timerScroller.alpha = 1;
    timerScroller.backgroundColor = UIColor.whiteColor()
  }
  
  @IBAction func SubmitPress(sender: AnyObject) {
    let question = questionInputText.text;
    let A1 = Ans1.text;
    let A2 = Ans2.text;
    let A3 = Ans3.text;
    let A4 = Ans4.text;
    
    if ((delegate?.checksInput(question!, A1: A1!, A2: A2!, A3: A3!, A4: A4!, timerWasSet:timerHasBeenSet)) == true) {
      return
    }
    
    let Answers = [A1!, A2!, A3!, A4!];
    
    delegate?.submitButtonPressed(question!,answerArray: Answers, questionDuration: time);
    
    
  }
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.backButtonPressed()
  }
  
  
  class func instanceFromNib(frame: CGRect) -> CreateQuestionContainerView {
    let view = UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CreateQuestionContainerView
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    
    return view
  }
  
  @IBAction func doneButtonPressed(sender: AnyObject) {
    timerScroller.alpha = 0
    Submit.alpha = 1
    setTimerButton.alpha = 1
    timerHasBeenSet = true
    timerLabel.alpha = 1
    time = Int(timerScroller.countDownDuration) - 7
    timerLabel.text = TimerUtil.getTextToShowInTimer(time)
    doneButton.alpha = 0
  }

}

extension CreateQuestionContainerView: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pollResultsCell = UINib(nibName: "AnswerTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "answerCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as! AnswerTableViewCell
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}


