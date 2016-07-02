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
      
      self.container?.delegate = self
      self.container?.setQuestionText(self.questionText)
      self.container?.setAnswers(self.answers)
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
    
    
    ModelInterface.sharedInstance.getCountdownSeconds(selectedQuestion.QID, completion: { (time) -> Void in
      if time > 0 {
        let currentTime = Int(NSDate().timeIntervalSince1970)
        let difference = currentTime - Int(time)
        if difference > 0 {
          if difference < 300 {
            self.container?.doneTimerLabel("Poll ended a couple moments ago")
          }
          else if difference < 3600 {
            let minutes = Int(difference/60)
            self.container?.doneTimerLabel("Poll ended \(minutes) minute ago")
          }
          else if difference < 86400 {
            let hours = Int(difference/3600)
            if hours > 1 {
              self.container?.doneTimerLabel("Poll ended \(hours) hours ago")
            } else {
              self.container?.doneTimerLabel("Poll ended \(hours) hour ago")
            }
          }
          else {
            let days = Int(difference/86400)
            if days > 1 {
              self.container?.doneTimerLabel("Poll ended \(days) days ago")
            } else {
              self.container?.doneTimerLabel("Poll ended \(days) day ago")
            }
            
          }
        } else {
          self.createTimer(Int(time) - currentTime)
        }
      }
    })
  }
  
  func createTimer(startingTime: Int) {
    totalSeconds = startingTime
    updateTimer()
    //    let hour_temp = totalSeconds/3600
    //    let min_temp = totalSeconds/60
    //    let sec_temp = totalSeconds-60*(min_temp)
    //    container?.updateTimerLabel(sec_temp, mins: min_temp, hours: hour_temp)
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(PollUserViewController.updateTimer)), userInfo: nil, repeats: true)
    
  }
  
  //IPA-126
  func updateTimer() {
    if(totalSeconds>0) {
      totalSeconds -= 1
      
//      hours = totalSeconds/3600
//      minutes = (totalSeconds - hours*3600) / 60
//      seconds = totalSeconds - hours*3600 - minutes*60
      container?.updateTimerLabel(TimerUtil.totalSecondsToString(totalSeconds))
    } else {
      timer.invalidate()
      
      let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
      performSegueWithIdentifier(nextRoom, sender: self)
    }
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
      // print("selected answer is: \(answer) ,printed from viewController")
      let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
      performSegueWithIdentifier(nextRoom, sender: self)
      
    }
  }
  func backButtonPushed() {
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
}
