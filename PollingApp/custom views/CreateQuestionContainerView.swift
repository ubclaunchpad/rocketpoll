//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  func shiftView()
  func stringFromQuestionDuration(currentTimeAway: Int, endTime: NSDate, setButtonTitle: (String) -> ())
}

class CreateQuestionContainerView: UIView {
  
  @IBOutlet weak var setTimerButton: UIButton!
  
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
  
  var delegate: CreateQuestionViewContainerDelegate?
  
  @IBOutlet weak var questionInputText: UITextView!
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var setTimerView: UIView!
  
  var time: Int = 0;
  
  var answers:[AnswerText] = ["",""]
  var correctAnswer:Int = -1
  
  var answerStrings = [AnswerText]()
  
  var currentTimeAway:Int = 1
  var endTime:NSDate?
  
  @IBOutlet weak var questionHeight: NSLayoutConstraint!
  @IBOutlet weak var endTimerLabel: UIButton!
  
  @IBAction func setTimerButtonPressed(sender: AnyObject) {
    
    setTimerView.hidden = false
    
    delegate?.shiftView()
    endTime = calendar.dateByAddingUnit(.Minute, value: currentTimeAway, toDate: NSDate(), options: [])!
    delegate?.stringFromQuestionDuration(currentTimeAway, endTime: endTime!, setButtonTitle: setEndTimerButtonTitle)
  }
  
  @IBAction func addAnswerButtonPressed(sender: UIButton) {
    answers.append("")
    self.tableView.reloadData()
    
  }
  
  @IBAction func deleteAnswerButtonPressed(sender: UIButton) {
    if answers.count > 2 {
      answers.removeLast()
      self.tableView.reloadData()
    }
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
//    delegate?.backButtonPressed()
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
  
  func deselectAnswer() {
    correctAnswer = -1
  }
  
}

extension CreateQuestionContainerView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pollResultsCell = UINib(nibName: "AnswerTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "answerCell")
    
    let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as! AnswerTableViewCell
    cell.identifier = indexPath.item
    cell.delegate = self
    cell.isCorrect = false
    cell.answerField.addTarget(cell, action: #selector(AnswerTableViewCell.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    cell.answerField.text = answers[indexPath.row]
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return answers.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}




