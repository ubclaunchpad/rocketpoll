//
//  FirstViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
import Firebase

class CampaignsViewController: UIViewController {
  
  private var questionIDDictionary = [QuestionText: QuestionID]()
  private var QIDToAIDSDictionary = [QuestionID:[AnswerID]]()
  private var QIDToAuthorDictionary = [QuestionID: Author]()
  private var QIDToTimeDictionary = [QuestionID: Double]()
  private var expiry = [String]()
  private var isExpired = [Bool]()
  
  var container: CampaignViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(currentUser)
    setup()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setup() {
    container = CampaignViewContainer.instancefromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
    ModelInterface.sharedInstance.processQuestionData { (listofAllQuestions) in
      self.container?.delegate = self
      self.fillInTheFields(listofAllQuestions)
    }
    let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
    let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
    
    container?.delegate = self
    self.container?.setRoomNameTitle(roomName)
  }
  
  
  func fillInTheFields (listofAllQuestions:[Question]) {
    let size = listofAllQuestions.count
    var tempquestionIDDictionary = [QuestionText: QuestionID]()
    var tempQIDToAIDSDictionary = [QuestionID:[AnswerID]]()
    var tempQIDToAuthorDictionary = [QuestionID: Author]()
    var tempQIDToTimeDictionary = [QuestionID: Double]()
    var tempquestions = [QuestionText]();
    var tempauthors = [Author]();
    var tempquestionsAnswered = [Bool]();
   
    for i in 0 ..< size  {
      let tempQuestionID = listofAllQuestions[i].QID;
      let time = listofAllQuestions[i].endTimestamp
      
      
      if self.updatingTimer(time, questionID: tempQuestionID) == false {
        tempquestions.append(listofAllQuestions[i].questionText)
        tempauthors.append(listofAllQuestions[i].author)
        tempquestionsAnswered.append(true)
        tempquestionIDDictionary[listofAllQuestions[i].questionText] = listofAllQuestions[i].QID
        tempQIDToAIDSDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].AIDS
        tempQIDToAuthorDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].author
        tempQIDToTimeDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].endTimestamp
      }
      if i == size - 1 {
        
        self.questionIDDictionary = tempquestionIDDictionary
        self.QIDToAIDSDictionary = tempQIDToAIDSDictionary
        self.QIDToAuthorDictionary = tempQIDToAuthorDictionary
        self.QIDToTimeDictionary = tempQIDToTimeDictionary
        
        self.container?.setExpiryMessages(self.expiry)
        self.container?.setIsExpired(self.isExpired)
        self.container?.setAuthors(tempauthors)
        self.container?.setQuestions(tempquestions)
        self.container?.setQuestionAnswered(tempquestionsAnswered)
        
        self.isExpired = [Bool]()
        self.expiry = [String]()
        self.container?.tableView.reloadData()
      }
      
    }
  }
  
  func updatingTimer (time:Double, questionID:QuestionID) -> (Bool) {
    
    var deleted = false
    if time > 0 {
      let currentTime = Int(NSDate().timeIntervalSince1970)
      let difference = currentTime - Int(time)
      let absDifference = abs(difference)
      
      if absDifference < 300 {
        if difference > 0 {
          self.isExpired.append(true)
          self.expiry.append("Poll ended a couple moments ago")
        } else {
          self.isExpired.append(false)
          self.expiry.append("Poll ends in a couple moments")
        }
      }
      else if absDifference < 3600 {
        let minutes = Int(absDifference/60)
        if difference > 0 {
          self.isExpired.append(true)
          self.expiry.append("Poll ended \(minutes) minutes ago")
        } else {
          self.isExpired.append(false)
          self.expiry.append("Poll ends in \(minutes) minutes")
        }
      }
      else if absDifference < 86400 {
        let hours = Int(absDifference/3600)
        if difference > 0 {
          
          self.isExpired.append(true)
          if hours > 1 {
            self.expiry.append("Poll ended \(hours) hours ago")
          } else {
            self.expiry.append("Poll ended \(hours) hour ago")
          }
        } else {
          self.isExpired.append(false)
          if hours > 1 {
            self.expiry.append("Poll ends in \(hours) hours")
          } else {
            self.expiry.append("Poll ends in \(hours) hour")
          }
        }
      }
      else {
        let days = Int(absDifference/86400)
        if difference > 0 {
          deleted = true
          ModelInterface.sharedInstance.removeQuestion(questionID)
        } else {
          self.isExpired.append(false)
          if days > 1 {
            self.expiry.append("Poll ends in \(days) days")
          } else {
            self.expiry.append("Poll ends in \(days) day")
          }
        }
        
      }
      
    }
    
    return deleted
  }
}


extension CampaignsViewController: CampaignViewContainerDelegate {
  func questionSelected(question: QuestionText) {
    if let questionID = questionIDDictionary[question] {
      print(question)
      let AIDS = QIDToAIDSDictionary[questionID]!
      let author = QIDToAuthorDictionary[questionID]!
      let time = QIDToTimeDictionary[questionID]!
      if (author == currentUser) {
        ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author, time:time)
        let nextRoom = ModelInterface.sharedInstance.segueTotoPollAdminVCFromCampaign()
        performSegueWithIdentifier(nextRoom, sender: self)
        
      } else {
        
        ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author, time: time)
        let questionSegue = ModelInterface.sharedInstance.segueToQuestion()
        performSegueWithIdentifier(questionSegue, sender: self)
      }
      
    }
  }
  func newQuestionSelected() {
    let newQuestionSegue = ModelInterface.sharedInstance.segueToCreateNewQuestion()
    performSegueWithIdentifier(newQuestionSegue, sender: self)
  }
  
  func resultsButtonSelected(question: QuestionText) {
    if let questionID = questionIDDictionary[question] {
      
      let AIDS = QIDToAIDSDictionary[questionID]!;
      let author = QIDToAuthorDictionary[questionID]!;
      let time = QIDToTimeDictionary[questionID]!;
      ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author, time:time)
      let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
      performSegueWithIdentifier(nextRoom, sender: self)
    }
  }
  
  
  
  func refreshQuestions() {
    setup()
  }
  
  
}

