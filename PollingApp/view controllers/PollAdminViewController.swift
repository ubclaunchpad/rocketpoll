//
//  PollAdminViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.


import UIKit

final class PollAdminViewController: UIViewController {
  
  //TODO: change this into a struct. IPA-123
  private var hours = 0
  private var minutes = 0
  private var seconds = 0
  private var totalSeconds = 0
  private var timerQuestion = 0.0
  private var timer = NSTimer()
  private var questionID:QuestionID = ""
  private var questionText:QuestionText = ""
  private var answerIDDictionary = [AnswerText: AnswerID]()
  private var answers:[AnswerText] = []
  private var correctAnswers:[AnswerText] = []
  private var sumuserresults = 0;
   var answerIDs:[AnswerID] = []
  private var numsubmitforeachAns:[[NSString:Int]] = [[:]]
  private var tallyIDDictioanry = [AnswerText:String]()
  var hello = "";
  
  var container: PollAdminViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(hello);
    addContainerToVC()
  }
  
  func addContainerToVC() {
    container = PollAdminViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
    
    answerIDs = []
    answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
    timerQuestion = ModelInterface.sharedInstance.getSelectedQuestion().endTimestamp
    
    ModelInterface.sharedInstance.processAnswerData(answerIDs, completionHandler: { (listofAllAnswers) in
      self.answerIDDictionary = [AnswerText: AnswerID]()
      self.answers = []
      self.correctAnswers = []
      self.fillInTheFields(listofAllAnswers)
      
      self.questionID = ModelInterface.sharedInstance.getSelectedQuestion().QID
      self.container?.setTally(self.tallyIDDictioanry)
      
      self.container?.delegate = self
      self.container?.setQuestionText(self.questionText)
      self.container?.setAnswers(self.answers)
      self.container?.setCorrectAnswers(self.correctAnswers)
    
      self.container?.AnswerTable.reloadData()
    })
    setCountDown();
  }
  
  func fillInTheFields(listofAllAnswers: [Answer]) {
    
    self.questionText = ModelInterface.sharedInstance.getSelectedQuestion().questionText
    let size = listofAllAnswers.count
    for i in 0 ..< size  {
      let tempAnswer = listofAllAnswers[i].answerText
      self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
      self.answers.append(tempAnswer)
      self.tallyIDDictioanry[tempAnswer] = String(listofAllAnswers[i].tally);
      if (listofAllAnswers[i].isCorrect) {
        self.correctAnswers.append(tempAnswer)
      }
      else {
        self.correctAnswers.append(UIStringConstants.notCorrect)
      }
    }
  }
  
  func createTimer (startingTime: Int) {
    totalSeconds = startingTime
    updateTimer()
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(PollUserViewController.updateTimer)),userInfo: nil, repeats: true)
  }
  
  func updateTimer() {
    if (totalSeconds > 0) {
      totalSeconds -= 1
      container?.updateTimerLabel(TimerUtil.totalSecondsToString(totalSeconds))
    } else {
      timer.invalidate()
      // TODO: SEGUE to next view
      let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
      performSegueWithIdentifier(nextRoom, sender: self)
    }
  }
  
  func setCountDown () {
    if self.timerQuestion > 0 {
      let currentTime = Int(NSDate().timeIntervalSince1970)
      let difference = currentTime - Int(self.timerQuestion)
      if difference <= 0 {
        self.createTimer(Int(self.timerQuestion) - currentTime)
      }
    }
  }
  
  func deleteQuestion(){
    ModelInterface.sharedInstance.stopTimer(questionID)
    ModelInterface.sharedInstance.removeQuestion(questionID)
    segueToCampaign()
  }
}

extension PollAdminViewController: PollAdminViewContainerDelegate {
  
  func segueToResult() {
    ModelInterface.sharedInstance.stopTimer(questionID)
    let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
    //print("SegueToResult");
  }
  func displayConfirmationMessage() {
    let deleteAlert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete your quesiton?", preferredStyle: UIAlertControllerStyle.Alert)
    deleteAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in deleteAlert.dismissViewControllerAnimated(true, completion: nil)
    }))
    deleteAlert.addAction(UIAlertAction(title: "Yes", style: .Cancel, handler: { (action: UIAlertAction!) in
      self.deleteQuestion()
    }))
    presentViewController(deleteAlert, animated: true, completion: nil)
  }
  func segueToCampaign() {
    let nextRoom =  ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
}
