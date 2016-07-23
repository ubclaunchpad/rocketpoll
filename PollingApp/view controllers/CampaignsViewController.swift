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
  
  // Information to send other view controllers
  private var sendAIDS = [AnswerID]()
  private var sendTime = 0.0
  private var sendQuestionText = "";
  private var sendQID = "";
  
  var container: CampaignViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerToVC()
    Log.debug("loaded campaign view")
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
    questionIDDictionary = [QuestionText: QuestionID]()
    QIDToAIDSDictionary = [QuestionID:[AnswerID]]()
    QIDToAuthorDictionary = [QuestionID: Author]()
    QIDToTimeDictionary = [QuestionID: Double]()
    questions = [QuestionText]();
    authors = [Author]();
    questionsAnswered = [Bool]();
    expiry = [String]()
    isExpired = [Bool]()
    
    
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    switch segue.identifier!  {
    case ModelInterface.sharedInstance.segueTotoPollAdminVCFromCampaign():
      let viewController:PollAdminViewController = segue.destinationViewController as! PollAdminViewController
      viewController.answerIDs = sendAIDS
      viewController.questionText = sendQuestionText
      viewController.questionID = sendQID
      viewController.timerQuestion = sendTime
      break
    case ModelInterface.sharedInstance.segueToQuestion():
      let viewController:PollUserViewController = segue.destinationViewController as! PollUserViewController
      viewController.answerIDs = sendAIDS
      viewController.questionID = sendQID
      viewController.questionText = sendQuestionText
      break
    case ModelInterface.sharedInstance.segueToResultsScreen():
      let viewController:PollResultsViewController = segue.destinationViewController as! PollResultsViewController
      viewController.questionID = sendQID
      viewController.questionText = sendQuestionText
      viewController.answerIDs = sendAIDS
      break
    default: break
    }
  }
  
}


extension CampaignsViewController: CampaignViewContainerDelegate {
  //IPA-129
  func questionSelected(question: QuestionText) {
    if let questionID = questionIDDictionary[question] {
      let author = QIDToAuthorDictionary[questionID]!
      sendQuestionText = question
      sendAIDS = QIDToAIDSDictionary[questionID]!

      sendTime = QIDToTimeDictionary[questionID]!
      sendQID = questionID
      if (author == currentUser) {
        let nextRoom = ModelInterface.sharedInstance.segueTotoPollAdminVCFromCampaign()
        performSegueWithIdentifier(nextRoom, sender: self)
        
      } else {
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
      sendQuestionText = question
      sendAIDS = QIDToAIDSDictionary[questionID]!
      sendTime = QIDToTimeDictionary[questionID]!
      sendQID = questionID
      let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
      performSegueWithIdentifier(nextRoom, sender: self)
    }
  }
  
  func setExpirationDate (time:Double, QID:QuestionID) -> Bool {
    var deleted = false
    guard time > 0 else {
      return deleted
    }
    
    let currentTime = Int(NSDate().timeIntervalSince1970)
    let difference = currentTime - Int(time)
    let absDifference = abs(difference)
    
    if absDifference < UITimeConstants.moment {
      if difference > 0 {
        self.isExpired.append(true)
        self.expiry.append("\(UITimeRemaining.endedMoments)")
      } else {
        self.isExpired.append(false)
        self.expiry.append("\(UITimeRemaining.endsMoments)")
      }
    }
    else if absDifference < UITimeConstants.oneHourinSeconds {
      let minutes = absDifference/UITimeConstants.oneMinuteinSeconds
      if difference > 0 {
        self.isExpired.append(true)
        self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endedMinutes, time: minutes))")
      } else {
        self.isExpired.append(false)
        self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endsMinutes, time: minutes))")
      }
    }
    else if absDifference < UITimeConstants.oneDayinSeconds {
      let hours = Int(absDifference/UITimeConstants.oneHourinSeconds)
      if difference > 0 {
        
        self.isExpired.append(true)
        if hours > 1 {
          self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endedHours, time: hours))")
        } else {
          self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endedHour, time: hours))")
        }
      } else {
        self.isExpired.append(false)
        if hours > 1 {
          self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endsHours, time: hours))")
        } else {
          self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endsHour, time: hours))")
        }
      }
    }
    else {
      let days = Int(absDifference/UITimeConstants.oneDayinSeconds)
      if difference > 0 {
        deleted = true
        ModelInterface.sharedInstance.removeQuestion(QID)
      } else {
        self.isExpired.append(false)
        if days > 1 {
          self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endsDays, time: days))")
        } else {
          self.expiry.append("\(StringUtil.fillInString(UITimeRemaining.endsDay, time: days))")
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

