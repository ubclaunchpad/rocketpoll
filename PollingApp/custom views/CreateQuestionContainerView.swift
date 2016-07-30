//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  
  func submitButtonPressed(question: QuestionText, answerArray: [AnswerID], correctAnswer: Int, questionDuration: Int)
  func backButtonPressed()
  func checksInput (question:QuestionText?, answerStrings:[AnswerText?], correctAnswer:Int, timerWasSet:Bool) -> Bool}

class CreateQuestionContainerView: UIView {
  @IBOutlet weak var timerLabel: UILabel!
  
  @IBOutlet weak var doneButton: UIButton!
  
  @IBOutlet weak var setTimerButton: UIButton!
  
  @IBOutlet weak var timerScroller: UIDatePicker!
  
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
  
  var delegate: CreateQuestionViewContainerDelegate?
  
  @IBOutlet weak var questionInputText: UITextField!
  
  @IBOutlet weak var tableView: UITableView!
  
  var timerHasBeenSet = false
  
  var time: Int = 0;
  
  var answerIdentifierIndex = 4
  
  var answerIdentifier:[Int] = [1, 2, 3, 4]
  var answers = [Int: String]()
  var correctAnswer:Int = 0
  
  var answerStrings = [AnswerText?]()
  var unwrappedAnswerStrings = [AnswerText]()
  
  @IBAction func setTimerButtonPressed(sender: AnyObject) {
    doneButton.alpha = 1;
    Submit.alpha = 0
    setTimerButton.alpha = 0;
    timerScroller.alpha = 1;
    timerScroller.backgroundColor = UIColor.whiteColor()
    timerScroller.layer.zPosition = 1
    doneButton.layer.zPosition = 1
  }
  
    @IBAction func AddAnswerButtonPressed(sender: UIButton) {
      answerIdentifierIndex += 1
      answerIdentifier.append(answerIdentifierIndex)
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.tableView.reloadData()
      })
    
    }
    
    
  @IBAction func DeleteAnswerButtonPressed(sender: AnyObject) {
    
    if answerIdentifierIndex > 2 {
      answerIdentifier.removeLast()
    

      answerIdentifierIndex -= 1
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.tableView.reloadData()
      })
    }
  }

  @IBAction func SubmitPress(sender: AnyObject) {
    let question = questionInputText.text
    var answerStrings = [AnswerText?]()
    var unwrappedAnswerStrings = [AnswerText]()
    
    if answers.count > 1{
      for index in 1...answerIdentifierIndex {
        answerStrings.append(answers[index])
        unwrappedAnswerStrings.append(answers[index]!)
      }
    }
    
    if ((delegate?.checksInput(question, answerStrings:answerStrings, correctAnswer: correctAnswer, timerWasSet:timerHasBeenSet)) == true) {
      return
    }
    
    delegate?.submitButtonPressed(question!,answerArray: unwrappedAnswerStrings, correctAnswer: correctAnswer, questionDuration: time);
    
    
  }
  
  
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.backButtonPressed()
  }
  
  
  class func instanceFromNib(frame: CGRect) -> CreateQuestionContainerView {
    let view = UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CreateQuestionContainerView
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    view.tableView.separatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2 )
    
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
    setTimerButton.setTitle("\(TimerUtil.formatSecondsToHHMMSS(time))", forState: UIControlState.Normal)
  }
  
}

extension CreateQuestionContainerView: AnswerTableViewCellDelegate {
  
  func updateAnswer(identifier: Int, answer: String) {
    answers[identifier] = answer
    print(answer)
  }
  
  func updateCorrectAnswer(identifier: Int) {
    for cell in tableView.visibleCells {
      let answerCell = cell as! AnswerTableViewCell
      if answerCell.identifier != identifier {
        answerCell.isCorrect = false
      }
    }
    correctAnswer = identifier
  }
  
  func deselectAnswer(identifier: Int) {
    correctAnswer = 0
  }
}

extension CreateQuestionContainerView: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pollResultsCell = UINib(nibName: "AnswerTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "answerCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as! AnswerTableViewCell
    cell.identifier = answerIdentifier[indexPath.item]
    cell.delegate = self
    cell.isCorrect = false
    cell.answerField.addTarget(cell, action: #selector(AnswerTableViewCell.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return answerIdentifier.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}


