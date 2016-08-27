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
  private var timer = NSTimer()
  
  var totalNumberOfUserAnswers: Int = 0
  var container: PollAdminViewContainer?
  
  //Information to send to Poll Results View Controller
  private var sendQuestionText = "";
  private var sendAnswer:Answer?
  //Recieved information from a View Controller
  var recievedQuestion:Question?
  
  var correctAnswers:[AnswerText] = []
  var answers:[Answer] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerToVC()
    setNavigationBar()
  }
  
  override func viewDidAppear(animated: Bool) {
    self.title = "ADMIN"
    setCountDown()

    
  }
  
  func addContainerToVC() {
    
    container = PollAdminViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    container?.AnswerTable.tableFooterView = UIView()
    ModelInterface.sharedInstance.processAnswerData((recievedQuestion?.AIDS)!, completionHandler: { (listofAllAnswers) in
      self.view.addSubview(self.container!)
      self.answers = []
      self.totalNumberOfUserAnswers = 0
      self.fillInTheFields(listofAllAnswers)
      
      self.container?.delegate = self
      self.container?.setQuestion(self.recievedQuestion!)
      self.container?.setAnswers(self.answers)
      self.container?.setCorrectAnswers(self.correctAnswers)
      self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
      self.container?.AnswerTable.reloadData()
    })
  }
  
  func setNavigationBar() {
    let backItem = UIBarButtonItem(image: UIImage(named: "Back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PollAdminViewController.popSegue))
    navigationItem.leftBarButtonItem = backItem
    let stopItem = UIBarButtonItem(image: UIImage(named: "Stop"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PollAdminViewController.stopQuestion))
    let removeItem = UIBarButtonItem(image: UIImage(named: "Remove"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PollAdminViewController.displayConfirmationMessage))
    navigationItem.rightBarButtonItems = [removeItem, stopItem]
  }
  
  func fillInTheFields(listofAllAnswers: [Answer]) {
    self.answers = listofAllAnswers
    let size = listofAllAnswers.count
    for i in 0 ..< size  {
      let tempAnswer = listofAllAnswers[i].answerText
      self.totalNumberOfUserAnswers += listofAllAnswers[i].tally
      if (listofAllAnswers[i].isCorrect) {
        self.correctAnswers.append(tempAnswer)
      }
      else {
        self.correctAnswers.append(UIStringConstants.notCorrect)
      }
    }
  }
  
  func getTotalTally () {
    ModelInterface.sharedInstance.processAnswerData((recievedQuestion?.AIDS)!, completionHandler: { (listofAllAnswers) in
      let size = listofAllAnswers.count
      var sum = 0
      for i in 0 ..< size  {
        sum += listofAllAnswers[i].tally
      }
      self.container?.showTotalTally(sum)
      self.container?.displayDone()
      
    })
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
      getTotalTally()
    }
  }
  
  func setCountDown () {
    
    if self.recievedQuestion?.endTimestamp > 0 {
      let currentTime = Int(NSDate().timeIntervalSince1970)
      let difference = currentTime - Int((self.recievedQuestion?.endTimestamp)!)
      if difference <= 0 {
        self.createTimer(Int((self.recievedQuestion?.endTimestamp)!) - currentTime)
      }else {
        getTotalTally()
      }
      
    } else {
      getTotalTally()
    }
  }
  
  func deleteQuestion(){
    ModelInterface.sharedInstance.stopTimer((recievedQuestion?.QID)!)
    ModelInterface.sharedInstance.removeQuestionAndAnswer(recievedQuestion!)
    
    segueToCampaign()
  }
  
  func stopQuestion() {
    timer.invalidate()
    ModelInterface.sharedInstance.stopTimer((recievedQuestion?.QID)!)
    getTotalTally()
  }
  
  func displayConfirmationMessage() {
    let deleteAlert = UIAlertController(title: "\(alertMessages.confirmation)", message: "\(alertMessages.confirmationMessage)", preferredStyle: UIAlertControllerStyle.Alert)
    deleteAlert.addAction(UIAlertAction(title: "\(alertMessages.no)", style: .Default, handler: { (action: UIAlertAction!) in deleteAlert.dismissViewControllerAnimated(true, completion: nil)
    }))
    deleteAlert.addAction(UIAlertAction(title: "\(alertMessages.yes)", style: .Cancel, handler: { (action: UIAlertAction!) in
      self.deleteQuestion()
    }))
    presentViewController(deleteAlert, animated: true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == ModelInterface.sharedInstance.segueToWhoVotedForVCFromAdmin()) {
      let viewController:WhoVotedForViewController = segue.destinationViewController as! WhoVotedForViewController
      viewController.selectedAnswer = sendAnswer
      viewController.questionText = sendQuestionText
      self.title = ""
    }
  }
}

extension PollAdminViewController: PollAdminViewContainerDelegate {
  func segueToCampaign() {
    let nextRoom =  ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  func popSegue() {
    self.navigationController?.popToViewController((self.navigationController?.viewControllers.first)!, animated: true)
  }
  
  func segueToWhoVotedFor(selectedAnswer:Answer) {
    sendAnswer = selectedAnswer
    sendQuestionText = (recievedQuestion?.questionText)!
    let nextRoom = ModelInterface.sharedInstance.segueToWhoVotedForVCFromAdmin()
    performSegueWithIdentifier(nextRoom, sender: self)
    
  }
  
}
