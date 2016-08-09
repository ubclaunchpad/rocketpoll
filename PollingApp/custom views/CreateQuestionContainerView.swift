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
  func shiftView()
  func stringFromQuestionDuration(currentTimeAway: Int, endTime: NSDate, setButtonTitle: (String) -> ())
  func showAlertController(title: String)
}

class CreateQuestionContainerView: UIView {
  
  @IBOutlet weak var setTimerButton: UIButton!

  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
  
  var delegate: CreateQuestionViewContainerDelegate?
  
  @IBOutlet weak var questionInputText: UITextField!
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var setTimerView: UIView!
  
  var time: Int = 0;
  
  var answerIdentifier:[Int] = [1, 2, 3, 4]
  var answers = [Int: String]()
  var correctAnswer:Int = 0
  
  var currentTimeAway:Int = 1
  var endTime:NSDate?
  
  @IBOutlet weak var endTimerLabel: UIButton!
  
  @IBAction func setTimerButtonPressed(sender: AnyObject) {

    setTimerView.hidden = false
    
    delegate?.shiftView()
    endTime = calendar.dateByAddingUnit(.Minute, value: currentTimeAway, toDate: NSDate(), options: [])!
    delegate?.stringFromQuestionDuration(currentTimeAway, endTime: endTime!, setButtonTitle: setEndTimerButtonTitle)
  }
  
  @IBAction func SubmitPress(sender: AnyObject) {
    let question = questionInputText.text;
    let A1 = answers[1]
    let A2 = answers[2]
    let A3 = answers[3]
    let A4 = answers[4]
    
    
    guard question != "" else {
      delegate?.showAlertController(alertMessages.emptyQuestions)
      return
    }
    guard !StringUtil.containsBadCharacters(question!) else {
      delegate?.showAlertController(alertMessages.symbolQuestion)
      return
    }
    guard A1 != nil && A2 != nil && A3 != nil && A4 != nil else {
      delegate?.showAlertController(alertMessages.emptyAnswer)
      return
    }
    guard !StringUtil.containsBadCharacters(A1!) &&
          !StringUtil.containsBadCharacters(A2!) &&
          !StringUtil.containsBadCharacters(A3!) &&
          !StringUtil.containsBadCharacters(A4!) else {
            delegate?.showAlertController(alertMessages.symbolAnswer)
            return
    }
    guard correctAnswer != 0 else {
      delegate?.showAlertController(alertMessages.noCorrectAnswer)
      return
    }
    let tempAnswers = [A1!, A2!, A3!, A4!]
    guard StringUtil.uniqueString(tempAnswers) == true else {
      delegate?.showAlertController(alertMessages.duplicateAnswer)
      return
    }
    
    time = currentTimeAway
    
    delegate?.submitButtonPressed(question!,answerArray: tempAnswers, correctAnswer: correctAnswer, questionDuration: time);
  }
  
  @IBAction func changeTime(sender: UIButton) {
    currentTimeAway += setTimerValues[sender.tag]
    if currentTimeAway <= 0 {
      currentTimeAway = 1
    }
    endTime = calendar.dateByAddingUnit(.Minute, value: currentTimeAway, toDate: NSDate(), options: [])!
    delegate?.stringFromQuestionDuration(currentTimeAway, endTime: endTime!, setButtonTitle: setEndTimerButtonTitle)
  }
  
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.backButtonPressed()
  }
  
  func setEndTimerButtonTitle(message: String) {
    endTimerLabel.setTitle(message, forState: .Normal)
  }
  
  func hideTimerView() {
    setTimerView.hidden = true
  }
  
  class func instanceFromNib(frame: CGRect) -> CreateQuestionContainerView {
    let view = UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CreateQuestionContainerView
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    view.tableView.separatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2 )
    
    return view
  }
  
}

extension CreateQuestionContainerView: AnswerTableViewCellDelegate {
  
  func updateAnswer(identifier: Int, answer: String) {
    answers[identifier] = answer
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
    return 4
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}


