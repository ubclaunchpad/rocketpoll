//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

final class PollUserViewController: UIViewController {
  private var answerIDDictionary = [AnswerText: AnswerID]()
  private var tallyDictionary = [AnswerID: Int]()
  private var hours = 0
  private var minutes = 0
  private var seconds = 0
  private var totalSeconds = 0
  private var timer = NSTimer()
  private var answers:[AnswerText] = []
  private var answerIDs:[AnswerID] = []
  private var questionText:QuestionText = ""
  private var questionID:QuestionID = ""
  
  var container: PollUserViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  func setup() {
    // add your container class to view
    let viewSize = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
    container = PollUserViewContainer.instanceFromNib(viewSize)
    view.addSubview(container!)
    
    self.answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
    ModelInterface.sharedInstance.processAnswerData(self.answerIDs) { (listofAllAnswers) in
      self.fillInTheFields(listofAllAnswers)
      
      self.container?.setQuestionText(self.questionText)
      self.container?.setAnswers(self.answers)
      self.container?.delegate = self
      self.container?.tableView.reloadData()
      
    }
  }
  
  func fillInTheFields (listofAllAnswers:[Answer]) {
    let size = listofAllAnswers.count
    for i in 0 ..< size  {
      let tempAnswer = listofAllAnswers[i].answerText
      self.answerIDDictionary[tempAnswer] = listofAllAnswers[i].AID
      self.answers.append(tempAnswer)
      self.tallyDictionary[listofAllAnswers[i].AID] = listofAllAnswers[i].tally
    }
    self.questionID = selectedQuestion.QID
    self.questionText = selectedQuestion.questionText
    
    setCountdown(questionID);
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
        self.performSegueWithIdentifier(nextRoom, sender: self)
      } else {
        self.createTimer(Int(time) - currentTime)
      }
      
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension PollUserViewController: PollUserViewContainerDelegate {
  func answerSelected(answer: AnswerText) {
    if let selectedAnswerID = answerIDDictionary[answer] {
      let tally = tallyDictionary[selectedAnswerID]!;
      print("Answer:\(answer) HAD this many votes: \(tally)")
      ModelInterface.sharedInstance.setUserAnswer(tally, answerID: selectedAnswerID)
      let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
      performSegueWithIdentifier(nextRoom, sender: self)
    }
  }
  func backButtonPushed() {
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
}
