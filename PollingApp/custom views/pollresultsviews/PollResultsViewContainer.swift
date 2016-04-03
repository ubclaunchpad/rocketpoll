//
//  pollresultsviews.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollResultsViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var resultsTableView: UITableView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var totalAnswersLabel: UILabel!
  private var answers: [Answer] = []
  private var correctAnswer: Answer = ""
  private var totalNumberOfAnswers: Int = 0;
  private var numberOfResponsesPerAnswer: [Int] = [];
  
  class func instanceFromNib(frame: CGRect) -> PollResultsViewContainer {
    let view = UINib(nibName: "PollResultsViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollResultsViewContainer
    view.frame = frame
    view.resultsTableView.delegate = view
    view.resultsTableView.dataSource = view
    view.resultsTableView.allowsSelection = false
    return view
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pollResultsCell = UINib(nibName: "PollResultsTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "resultsCell")
    let cell = self.resultsTableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath) as! PollResultsTableViewCell
    cell.setAnswerText(answers[indexPath.row])
    
    if(answers[indexPath.row] == correctAnswer){
      cell.changeCorrectAnswerColor()
    }
    
    if(totalNumberOfAnswers != 0){
      let results:Double = Double(numberOfResponsesPerAnswer[indexPath.row])/Double(totalNumberOfAnswers)*100
      cell.setResults(results)
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return answers.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
  
  func setQuestionLabelText (questionText: Question){
    questionLabel.text = questionText
  }
  
  func setAnswers (Answers: [Answer]){
    answers = Answers
    print(answers.count)
  }
  
  func setCorrectAnswer (rightAnswer:Answer){
    correctAnswer = rightAnswer
  }
  
  func setTotalNumberOfAnswers (totalNumOfAnswers:Int){
    totalNumberOfAnswers = totalNumOfAnswers
    totalAnswersLabel.text = ("Number of users that answered: \(totalNumberOfAnswers)")
  }
  
  func setNumberOfResponsesForAnswer (NumResponses:[Int]){
    numberOfResponsesPerAnswer = NumResponses
  }
}
