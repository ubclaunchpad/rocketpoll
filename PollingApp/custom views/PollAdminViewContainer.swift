//
//  PollAdminUserViewContainer.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-04-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit


protocol PollAdminViewContainerDelegate  {
  func segueToResult()
  func segueToCampaign()
  func displayConfirmationMessage()
}

class PollAdminViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  private var answers:[AnswerText] = []
  private var correctAnswers:[AnswerText] = []
  private var tallyIDDictionary = [AnswerText:String]()
  private var totalNumberOfAnswers: Int = 0;
  private var question:QuestionText = ""
  @IBOutlet weak var timer: UILabel!
  @IBOutlet weak var AnswerTable: UITableView!
  @IBOutlet weak var questionTextView: UITextView!
  
  var delegate: PollAdminViewContainerDelegate?
  
  @IBAction func backButton(sender: AnyObject) {
    delegate?.segueToCampaign();
  }
  
  @IBAction func goToResult(sender: AnyObject) {
    delegate?.segueToResult();
  }
  
  @IBAction func goToCampaign(sender: AnyObject) {
    
    delegate?.displayConfirmationMessage();
  }
  
  class func instanceFromNib(frame: CGRect) -> PollAdminViewContainer {
    let view = UINib(nibName: "PollAdminViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollAdminViewContainer
    view.frame = frame
    view.AnswerTable.delegate = view
    view.AnswerTable.dataSource = view
    return view
  }
  
  
  func setAnswers(Answers: [String]){
    answers = Answers
    
  }
  
  func setCorrectAnswers(Answers: [String]){
    correctAnswers = Answers
  }
  func setTally(tallyIDDictionary:[AnswerText:String]){
    self.tallyIDDictionary = tallyIDDictionary
  }
  
  
  func doneTimerLabel(string: String) {
    timer.text = string
  }
  
  func setQuestionText(questionText: String) {
    question = questionText
    questionTextView.text = questionText
  }
  
  func updateTimerLabel(timerString: String) {
    timer.text = timerString
  }
  func setTotalNumberOfAnswers (totalNumOfAnswers:Int){
    totalNumberOfAnswers = totalNumOfAnswers
  }
  
  // returns an approiate number of rows depending on the section
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == 0 ) {
      return 1
    }
    return  answers.count
    
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
//    if (indexPath.section == 0) {
//      let nib_name = UINib(nibName: "QuestionViewCell", bundle:nil)
//      tableView.registerNib(nib_name, forCellReuseIdentifier: "question")
//      
//      let cell = self.AnswerTable.dequeueReusableCellWithIdentifier("question", forIndexPath: indexPath) as! QuestionViewCell
//      cell.setQuestionLabel(question)
//      return cell
//      
//    }
    
    let nib_name = UINib(nibName: "AnswerAdminTableViewCell", bundle:nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "answeradminCell")
    
    let cell = self.AnswerTable.dequeueReusableCellWithIdentifier("answeradminCell", forIndexPath: indexPath) as! AnswerAdminTableViewCell
    
    cell.setAnswerText(answers[indexPath.row])
    cell.setisCorrect(correctAnswers[indexPath.row])
    cell.SetTallyLabel(tallyIDDictionary[answers[indexPath.row]]!)
    
    if (totalNumberOfAnswers != 0) {
      let tally = tallyIDDictionary[answers[indexPath.row]]!
      
      let results:Double = MathUtil.convertTallyResultsToPercentage(
        Double(tally)!,
        denominator: Double(totalNumberOfAnswers))
      
      cell.setBarGraph(results)
    }else{
      cell.setBarGraph(0)
    }
    return cell
    
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellDimensions.pollAdminCellHeight
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    if (section == 0) {
//      return "Question"
//    }
    return "Answers"
  }
  
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
}
