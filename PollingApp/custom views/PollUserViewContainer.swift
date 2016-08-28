//
//  PollUserViewContainer.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol PollUserViewContainerDelegate {
  func answerSelected(answer: Answer)
  func backButtonPushed()
}

class PollUserViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var totalLabel: UILabel!

  
  private var answers:[Answer] = []
  var selectedAnswer: AnswerText = ""
  var delegate: PollUserViewContainerDelegate?
  var previousCellID:Int = 0
  
  
  @IBOutlet weak var question: UILabel!
  
  @IBOutlet weak var timerLabel: UILabel!
  
  class func instanceFromNib(frame: CGRect) -> PollUserViewContainer {
    let view = UINib(nibName: "PollUserViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollUserViewContainer
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    view.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    view.tableView.backgroundColor = UIColor.clearColor()
    view.tableView.opaque = false
    return view
  }
  func setTotal(tally: Int) {
    totalLabel.text = ("\(StringUtil.fillInString(totalVotes, time: tally))")
  }
  
  func setAnswers(answers: [Answer]) {
    self.answers = answers
  }
  func setQuestionText(questionText: QuestionText) {
    question.text = questionText
  }
  func doneTimerLabel(string: String) {
    timerLabel.text = string
  }
  
  func updateTimerLabel(timerString: String) {
    timerLabel.text = timerString
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return answers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let nib_name = UINib(nibName: "AnswerViewTableViewCell", bundle:nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "answerCell\(indexPath.row)")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell\(indexPath.row)", forIndexPath: indexPath) as! AnswerViewTableViewCell
    cell.backgroundColor = UIColor.clearColor()
    cell.backgroundImage.image = UIImage(named: "AnswerCell")!
    cell.setAnswerText(answers[indexPath.row].answerText)
    cell.delegate = self
    cell.tag = 1000 + indexPath.row
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    delegate?.answerSelected(answers[indexPath.row])
  }
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.backButtonPushed()
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    //TODO: set tableView Cell size based on content size
  }

  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

extension PollUserViewContainer: AnswerViewTableViewCellDelegate {

  
}
