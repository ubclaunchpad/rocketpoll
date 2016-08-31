//
//  PollAdminUserViewContainer.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-04-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit


protocol PollAdminViewContainerDelegate  {
  func segueToCampaign()
  func segueToWhoVotedFor(selectedAnswer:Answer)
}

class PollAdminViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  private var answers:[Answer] = []
  private var question:Question?
  private var correctAnswers:[AnswerText] = []
  private var totalNumberOfAnswers: Int = 0
  @IBOutlet weak var timer: UILabel!
  @IBOutlet weak var AnswerTable: UITableView!
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var totalTally: UILabel!
  var delegate: PollAdminViewContainerDelegate?
  
  class func instanceFromNib(frame: CGRect) -> PollAdminViewContainer {
    let view = UINib(nibName: "PollAdminViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollAdminViewContainer
    view.frame = frame
    view.AnswerTable.delegate = view
    view.AnswerTable.dataSource = view
    view.AnswerTable.allowsSelection = true
    view.AnswerTable.separatorStyle = UITableViewCellSeparatorStyle.None
    view.AnswerTable.backgroundColor = UIColor.clearColor()
    view.AnswerTable.opaque = false
    return view
  }
  
  func setCorrectAnswers(Answers: [String]){
    correctAnswers = Answers
  }
  
  func doneTimerLabel(string: String) {
    timer.text = string
  }
  
  func setAnswers (answers: [Answer]) {
    self.answers = answers
  }
  
  func setQuestion (question: Question){
    self.questionLabel.text = question.questionText
  }
  
  func updateTimerLabel(timerString: String) {
    timer.text = timerString
  }
  func setTotalNumberOfAnswers (totalNumOfAnswers:Int){
    totalNumberOfAnswers = totalNumOfAnswers
  }
  
  func showTotalTally (totalNumOfAnswers:Int) {
    totalTally.hidden = false
    totalTally.text = "\(StringUtil.fillInString(totalVotes, time: totalNumOfAnswers))"
  }
  
  func displayDone () {
    timer.text = "done"
  }
  
  // returns an approiate number of rows depending on the section
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  answers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let nib_name = UINib(nibName: "AnswerAdminTableViewCell", bundle:nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "answeradminCell")
    let cell = self.AnswerTable.dequeueReusableCellWithIdentifier("answeradminCell", forIndexPath: indexPath) as! AnswerAdminTableViewCell
    
    cell.setAnswerText(answers[indexPath.row].answerText)
    cell.setisCorrect(correctAnswers[indexPath.row])
    cell.setTallyLabel(answers[indexPath.row].tally)
    
    if (totalNumberOfAnswers != 0) {
      let tally = answers[indexPath.row].tally
      
      let results:Double = MathUtil.convertTallyResultsToPercentage(
        Double(tally),
        denominator: Double(totalNumberOfAnswers))
      cell.setTallyLabel(answers[indexPath.row].tally)
      cell.setBarGraph(results)
    }else{
      cell.setBarGraph(0)
      cell.setTallyLabel(0)

    }
    cell.backgroundColor = UIColor.clearColor()
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    return cell
    
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    delegate?.segueToWhoVotedFor(answers[indexPath.row])
  }

  
}
