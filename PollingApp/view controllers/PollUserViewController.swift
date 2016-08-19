//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

final class PollUserViewController: UIViewController {
  private var totalTally = 0;
  private var tally = 0;
  private var hours = 0
  private var minutes = 0
  private var seconds = 0
  private var totalSeconds = 0
  private var timer = NSTimer()
  private var answers = [Answer]()
  private var chosenAnswerID: AnswerID = ""
  var container: PollUserViewContainer?
  var isTheQuestionExpired = true
  
  // Recieved infomration
  var questionText: QuestionText = ""
  var questionID: QuestionID = ""
  var answerIDs: [AnswerID] = []
  
  // Information to send to another view controller
  private var sendAIDS = [AnswerID]()
  private var sendQuestionText = ""
  private var sendQID = ""
  
  
  private var liveResultsOn = false
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    self.title = "VOTE"
  }
  
  func setup() {
    // add your container class to view
    let viewSize = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
    container = PollUserViewContainer.instanceFromNib(viewSize)
    view.addSubview(container!)
    ModelInterface.sharedInstance.processAnswerData(self.answerIDs) { (listofAllAnswers) in
     ModelInterface.sharedInstance.isItLiveResultsOn(self.questionID, completionHandler: { (isLiveResultsOn) in
      self.liveResultsOn = isLiveResultsOn
      self.setNavigationBar()
      self.answers = []
      self.totalTally = 0
      self.fillInTheFields(listofAllAnswers)
      self.container?.setQuestionText(self.questionText)
      self.container?.setAnswers(self.answers)
      self.container?.setTotal(self.totalTally)
      self.container?.delegate = self
      self.container?.tableView.reloadData()

     })
    }
    self.setCountdown(self.questionID)
    
  }
  
  func setNavigationBar() {
    navigationItem.leftBarButtonItem?.target = self
    navigationItem.leftBarButtonItem?.action = #selector(PollUserViewController.backButtonPushed)

    if (self.liveResultsOn) {
      let seeResults = UIBarButtonItem(title: "Results", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PollUserViewController.goToResults))
      self.navigationItem.rightBarButtonItem = seeResults

    }
  }
  
  func fillInTheFields (listofAllAnswers:[Answer]) {
    let size = listofAllAnswers.count
    self.answers = listofAllAnswers
    for i in 0 ..< size  {
      totalTally += listofAllAnswers[i].tally
    }
  }
  
  func createTimer(startingTime: Int) {
    totalSeconds = startingTime
    updateTimer()
    timer = NSTimer.scheduledTimerWithTimeInterval(
      1,
      target: self,
      selector: (#selector(PollUserViewController.updateTimer)),
      userInfo: nil,
      repeats: true)
  }
  
  func updateTimer() {
    if(totalSeconds>0) {
      totalSeconds -= 1
      container?.updateTimerLabel(TimerUtil.totalSecondsToString(totalSeconds))
    } else {
      timer.invalidate()
      sendQID = questionID
      sendQuestionText = questionText
      sendAIDS = answerIDs
      self.isTheQuestionExpired = true
      let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
      performSegueWithIdentifier(nextRoom, sender: self)
    }
  }
  func setCountdown(QID: String) {
    let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
    ModelInterface.sharedInstance.getCountdownSeconds(QID, completion: { (time) -> Void in
      guard time > 0 else {
        return
      }
      
      let currentTime = Int(NSDate().timeIntervalSince1970)
      let difference = currentTime - Int(time)
      if difference > 0 {
        self.sendQID = self.questionID
        self.sendQuestionText = self.questionText
        self.sendAIDS = self.answerIDs
        self.isTheQuestionExpired = true
        self.performSegueWithIdentifier(nextRoom, sender: self)
      } else {
        self.isTheQuestionExpired = false
        self.createTimer(Int(time) - currentTime)
      }
      
    })
  }
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == ModelInterface.sharedInstance.segueToResultsScreen()) {
      let viewController:PollResultsViewController = segue.destinationViewController as! PollResultsViewController
      viewController.questionID = sendQID
      viewController.questionText = sendQuestionText
      viewController.answerIDs = sendAIDS
      viewController.fromPollUser = true
      viewController.isTheQuestionExpired = self.isTheQuestionExpired
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  override func didMoveToParentViewController(parent: UIViewController?) {
    if parent == nil {
      backButtonPushed()
    }
  }
}

extension PollUserViewController: PollUserViewContainerDelegate {
  func answerSelected(answer: Answer) {
    if answer.AID != "" {
      tally = answer.tally
      chosenAnswerID =  answer.AID
    }
  }
  func backButtonPushed() {
    if (chosenAnswerID != "") {
      ModelInterface.sharedInstance.rememberAnswer(questionID, answerID: chosenAnswerID) { (DontAllowRevoting) in
        if (DontAllowRevoting) {
          let confirmAlert = UIAlertController(title: alertMessages.noRevoting, message:"", preferredStyle: UIAlertControllerStyle.Alert)
          confirmAlert.addAction(UIAlertAction(title: alertMessages.confirm, style: .Default, handler: { (action: UIAlertAction!) in confirmAlert.dismissViewControllerAnimated(true, completion: nil)
          }))
          self.presentViewController(confirmAlert, animated: true, completion: nil)
        } else {
          let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
          self.performSegueWithIdentifier(nextRoom, sender: self)
        }
        
      }
    } else {
      let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
      self.performSegueWithIdentifier(nextRoom, sender: self)
    }
  }

  func goToResults() {
    sendQID = questionID
    sendQuestionText = questionText
    sendAIDS = answerIDs
    let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }

}
