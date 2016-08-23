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
  private var hasAdminEndedTheQuestion = false
  var container: PollUserViewContainer?
  var isTheQuestionExpired = true
  var recievedQuestion:Question?
  
  var timerEnd:Bool = true

  // Information to send to another view controller
  private var sendQuestion:Question?
  
  private var liveResultsOn = false
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewDidAppear(animated: Bool) {
    self.title = "VOTE"
    self.setCountdown((self.recievedQuestion?.QID)!)
  }
  
  func setup() {
    // add your container class to view
    let viewSize = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
    container = PollUserViewContainer.instanceFromNib(viewSize)
    view.addSubview(container!)
    ModelInterface.sharedInstance.processAnswerData((self.recievedQuestion?.AIDS)!) { (listofAllAnswers) in
     ModelInterface.sharedInstance.isItLiveResultsOn((self.recievedQuestion?.QID)!, completionHandler: { (isLiveResultsOn) in
      self.liveResultsOn = isLiveResultsOn
      self.setNavigationBar()
      self.answers = []
      self.totalTally = 0
      self.fillInTheFields(listofAllAnswers)
      self.container?.setQuestionText((self.recievedQuestion?.questionText)!)
      self.container?.setAnswers(self.answers)
      self.container?.setTotal(self.totalTally)
      self.container?.delegate = self
      self.container?.tableView.reloadData()

     })
    }
        
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
    totalSeconds = startingTime-offsetTimer
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
      sendQuestion = recievedQuestion
      self.isTheQuestionExpired = true
      if (!hasAdminEndedTheQuestion) {
        let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
      }
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
        self.sendQuestion = self.recievedQuestion
        self.isTheQuestionExpired = true
        self.hasAdminEndedTheQuestion = true
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
      viewController.recievedQuestion = sendQuestion
      viewController.fromTimerEnd = timerEnd
      viewController.isTheQuestionExpired = self.isTheQuestionExpired
      self.title = ""
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
      ModelInterface.sharedInstance.rememberAnswer((self.recievedQuestion?.QID)!, answerID: chosenAnswerID) { (DontAllowRevoting) in
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
    sendQuestion = recievedQuestion
    let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
    timerEnd = false
    performSegueWithIdentifier(nextRoom, sender: self)
  }

}
