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
  @IBOutlet weak var totalAnswersLabel: UILabel!
  
  private var answers: [AnswerText] = []
  private var correctAnswer: AnswerText = ""
  private var totalNumberOfAnswers: Int = 0
  private var numberOfResponsesPerAnswer: [Int] = []
  private var questionText = ""
  private var yourAnswer = ""
  private var yourAnswerNumOfRespones = 0
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
    
    if indexPath.section == 0 {
      let nib_name = UINib(nibName: "QuestionResultViewCell", bundle:nil)
      tableView.registerNib(nib_name, forCellReuseIdentifier: "question")
      
      let cell = self.resultsTableView.dequeueReusableCellWithIdentifier("question", forIndexPath: indexPath) as! QuestionResultViewCell
      cell.displayQuestion(questionText)
      return cell
      
    } else if  indexPath.section == 1 && yourAnswer != "" {
  
      let pollResultsCell = UINib(nibName: "PollResultsTableViewCell", bundle: nil)
      tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "resultsCell")
      let cell = self.resultsTableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath) as! PollResultsTableViewCell
      
      cell.setAnswerText(yourAnswer)
      if(totalNumberOfAnswers != 0){
        let results:Double = MathUtil.convertTallyResultsToPercentage(Double(yourAnswerNumOfRespones), denominator: Double(totalNumberOfAnswers))
        cell.setResults(results)
        cell.setBarGraph(results)
        cell.SetTallyLabel(String(yourAnswerNumOfRespones))
      }else{
        cell.setResults(0)
        cell.setBarGraph(0)
        cell.SetTallyLabel(String(0))
      }
      if yourAnswer == correctAnswer {
        cell.changeCorrectAnswerColor()
      }
      return cell
    }
    
    let pollResultsCell = UINib(nibName: "PollResultsTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "resultsCell")
    let cell = self.resultsTableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath) as! PollResultsTableViewCell
    cell.setAnswerText(answers[indexPath.row])
    print(answers[indexPath.row])
    if(answers[indexPath.row] == correctAnswer){
      cell.changeCorrectAnswerColor()
    }
    
    if(totalNumberOfAnswers != 0){
      let results:Double = MathUtil.convertTallyResultsToPercentage(Double(numberOfResponsesPerAnswer[indexPath.row]), denominator: Double(totalNumberOfAnswers))
      cell.setResults(results)
      cell.setBarGraph(results)
      cell.SetTallyLabel(String(numberOfResponsesPerAnswer[indexPath.row]))
    }else{
      cell.setResults(0)
      cell.setBarGraph(0)
      cell.SetTallyLabel(String(0))
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var numberOfRows = 0;
    if (section == 0) {
      numberOfRows = 1
    } else if (section == 1 ) {
      if (yourAnswer != "") {
        numberOfRows = 1;
      } else  {
        numberOfRows = 0;
      }
    } else {
      numberOfRows  = answers.count
    }
    
    return numberOfRows
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
  
  func setQuestionLabelText (questionText: QuestionText){
    self.questionText = questionText
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
    totalAnswersLabel.text = ("\(StringUtil.fillInString(numberOfAnswers, time: totalNumberOfAnswers))")
  }
  
  func setYourAnswer (yourAnswer:String) {
    self.yourAnswer = yourAnswer
    for i in 0...answers.count-1  {
      if (answers[i] == yourAnswer) {
        yourAnswerNumOfRespones = numberOfResponsesPerAnswer[i]
        answers.removeAtIndex(i)
        numberOfResponsesPerAnswer.removeAtIndex(i)
        break
      }
    }
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
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
    var sectionName = ""
    if section == 0 {
      sectionName = "Question"
    } else if section == 1 {
  
      if (yourAnswer != "") {
        sectionName = "Your Answer"
      } else {
        sectionName = "You didn't answer"
      }
      
    } else {
      
      if (yourAnswer != "") {
        sectionName = "Other Answers"
      } else {
        sectionName = "Answers"
      }
    }
    
    return sectionName
  }
  
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3
  }
  
}
