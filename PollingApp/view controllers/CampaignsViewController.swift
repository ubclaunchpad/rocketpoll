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
  private var questions = [QuestionText]();
  private var authors = [Author]();
  private var questionsAnswered = [Bool]();
  private var expiry = [String]()
  private var isExpired = [Bool]()
  
  
  var container: CampaignViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerToVC()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func addContainerToVC() {
    container = CampaignViewContainer.instancefromNib(
      CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
    ModelInterface.sharedInstance.processQuestionData { (listofAllQuestions) in
      self.fillInTheFields(listofAllQuestions)
    }
    let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
    let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
    
    container?.delegate = self
    self.container?.setRoomNameTitle(roomName)
  }
  
  
  func fillInTheFields (listofAllQuestions:[Question]) {
    let size = listofAllQuestions.count
    for i in 0 ..< size  {
      let tempQuestionID = listofAllQuestions[i].QID;
      let time = listofAllQuestions[i].endTimestamp
    
      if setExpirationDate(time, QID: tempQuestionID) == false {
        self.questions.append(listofAllQuestions[i].questionText)
        self.authors.append(listofAllQuestions[i].author)
        self.questionsAnswered.append(true)
        self.questionIDDictionary[listofAllQuestions[i].questionText] = listofAllQuestions[i].QID
        self.QIDToAIDSDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].AIDS
        self.QIDToAuthorDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].author
        self.QIDToTimeDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].endTimestamp
      }
      if i == size - 1 {
        self.container?.setExpiryMessages(self.expiry)
        self.container?.setIsExpired(self.isExpired)
        self.container?.setAuthors(self.authors)
        self.container?.delegate = self
        self.container?.setQuestions(self.questions)
        self.container?.setQuestionAnswered(self.questionsAnswered)
        
        self.container?.tableView.reloadData()
      }
      
    }
  }
}


extension CampaignsViewController: CampaignViewContainerDelegate {
  //IPA-129
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
  
  func setExpirationDate (time:Double, QID:QuestionID) -> Bool {
    var deleted = false
   
    if time > 0 {
      let currentTime = Int(NSDate().timeIntervalSince1970)
      let difference = currentTime - Int(time)
      let absDifference = abs(difference)
      
      if absDifference < UINumConstants.moment {
        if difference > 0 {
          self.isExpired.append(true)
          self.expiry.append("Poll ended a couple moments ago")
        } else {
          self.isExpired.append(false)
          self.expiry.append("Poll ends in a couple moments")
        }
      }
      else if absDifference < UINumConstants.oneHourinSeconds {
        let minutes = Int(absDifference/UINumConstants.oneMinuteinSeconds)
        if difference > 0 {
          self.isExpired.append(true)
          self.expiry.append("Poll ended \(minutes) minutes ago")
        } else {
          self.isExpired.append(false)
          self.expiry.append("Poll ends in \(minutes) minutes")
        }
      }
      else if absDifference < UINumConstants.oneDayinSeconds {
        let hours = Int(absDifference/UINumConstants.oneHourinSeconds)
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
        let days = Int(absDifference/UINumConstants.oneDayinSeconds)
        if difference > 0 {
          deleted = true
          ModelInterface.sharedInstance.removeQuestion(QID)
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
    
    return deleted;

  }
  
  func refreshQuestions() {
    questionIDDictionary.removeAll()
    QIDToAIDSDictionary.removeAll()
    QIDToAuthorDictionary.removeAll()
    questions.removeAll()
    authors.removeAll()
    questionsAnswered.removeAll()
    expiry.removeAll()
    isExpired.removeAll()
    addContainerToVC()
  }
  
  
}

