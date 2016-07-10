//
//  pollresultsviews.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit


protocol PollResultsViewContainerDelegate {
  func goBackToCampaign()
  func presentConfirmationVaraible()
}



class PollResultsViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var resultsTableView: UITableView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var totalAnswersLabel: UILabel!
  
  private var answers: [AnswerText] = []
  private var correctAnswer: AnswerText = ""
  private var totalNumberOfAnswers: Int = 0;
  private var numberOfResponsesPerAnswer: [Int] = [];
  
  var delegate: PollResultsViewContainerDelegate?
  
  class func instanceFromNib(frame: CGRect) -> PollResultsViewContainer {
    let view = UINib(nibName: "PollResultsViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollResultsViewContainer
    view.frame = frame
    view.resultsTableView.delegate = view
    view.resultsTableView.dataSource = view
    view.resultsTableView.allowsSelection = false
    return view
  }
  
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.goBackToCampaign()
  }
  
  //TODO:IPA-132 Move this logic to VC or model
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pollResultsCell = UINib(nibName: "PollResultsTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "resultsCell")
    let cell = self.resultsTableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath) as! PollResultsTableViewCell
    cell.setAnswerText(answers[indexPath.row])
    
    if(answers[indexPath.row] == correctAnswer){
      cell.changeCorrectAnswerColor()
    }
    
    if(totalNumberOfAnswers != 0){
      let results:Double = MathUtil.convertTallyResultsToPercentage(Double(numberOfResponsesPerAnswer[indexPath.row]), denominator: Double(totalNumberOfAnswers))
      cell.setResults(results)
    }else{
      cell.setResults(0)
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return answers.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
  
  func setQuestionLabelText (questionText: QuestionText){
    questionLabel.text = questionText
  }
  
  func setAnswers (Answers: [AnswerText]){
    answers = Answers
    print(answers.count)
  }
  
  func setCorrectAnswer (rightAnswer:AnswerText){
    correctAnswer = rightAnswer
  }
  
  func setTotalNumberOfAnswers (totalNumOfAnswers:Int){
    totalNumberOfAnswers = totalNumOfAnswers
    totalAnswersLabel.text = ("Number of users that answered: \(totalNumberOfAnswers)")
  }
  
  func setNumberOfResponsesForAnswer (NumResponses:[Int]){
    numberOfResponsesPerAnswer = NumResponses
  }
  
  @IBAction func deleteButtonPressed(sender: AnyObject) {
    delegate?.presentConfirmationVaraible()
  }
  
  func makeDeleteButtonVisisble(){
    deleteButton.alpha = 1
  }
  
  func hideDeleteButton(){
    deleteButton.alpha = 0
  }
}
