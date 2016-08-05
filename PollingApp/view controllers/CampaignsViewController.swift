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
  
  
  private var questionsAnswered = [Bool]()
  
  private var listOfYourQuestions = [Question]()
  private var listOfAnsweredQuestions = [Question]()
  private var listOfUnansweredQuestions = [Question]()
  private var listOfExpiredQuestions = [Question]()
  
  
  // Information to send other view controllers
  private var sendAIDS = [AnswerID]()
  private var sendTime = 0.0
  private var sendQuestionText = ""
  private var sendQID = ""
  
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
      ModelInterface.sharedInstance.getListOfQuestionsUserAnswered({ (listOfAnsweredQIDs) in
        self.fillInTheFields(listofAllQuestions, listOfAnsweredQIDs:listOfAnsweredQIDs)
      })
      
    }
    let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
    let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
    
    container?.delegate = self
    self.container?.setRoomNameTitle(roomName)
  }
  
  
  func fillInTheFields (listofAllQuestions:[Question], listOfAnsweredQIDs: [QuestionID] ) {
    
    listOfYourQuestions.removeAll()
    listOfAnsweredQuestions.removeAll()
    listOfUnansweredQuestions.removeAll()
    listOfExpiredQuestions.removeAll()
    
    let size = listofAllQuestions.count
    for i in 0 ..< size  {
      if (listofAllQuestions[i].author == currentUser) {
        listOfYourQuestions.append(listofAllQuestions[i])
      }
      if (listOfAnsweredQIDs.contains(listofAllQuestions[i].QID)) {
        listOfAnsweredQuestions.append(listofAllQuestions[i])
      }
      let tempQuestion = DateUtil.setExpirationDate(listofAllQuestions[i])
      
      if (!tempQuestion.isExpired &&
        !listOfYourQuestions.contains(tempQuestion) &&
        !listOfAnsweredQuestions.contains(tempQuestion)) {
        listOfUnansweredQuestions.append(tempQuestion)
      }
      
      if (tempQuestion.isExpired &&
        !listOfYourQuestions.contains(tempQuestion) &&
        !listOfAnsweredQuestions.contains(tempQuestion)) {
        listOfExpiredQuestions.append(tempQuestion)
      }
    }
    
    self.container?.delegate = self
    self.container?.setYourQuestions(listOfYourQuestions)
    self.container?.setAnsweredQuestion(listOfAnsweredQuestions)
    self.container?.setUnansweredQuestions(listOfUnansweredQuestions)
    self.container?.setExpiredQuestions(listOfExpiredQuestions)
    self.container?.tableView.reloadData()
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
  func questionSelected(question: Question) {
    
    let author = question.author
    sendQuestionText = question.questionText
    sendAIDS = question.AIDS
    
    sendTime = question.endTimestamp
    sendQID = question.QID
    if (author == currentUser) {
      let nextRoom = ModelInterface.sharedInstance.segueTotoPollAdminVCFromCampaign()
      performSegueWithIdentifier(nextRoom, sender: self)
      
    } else {
      if (!question.isExpired) {
        let questionSegue = ModelInterface.sharedInstance.segueToQuestion()
        performSegueWithIdentifier(questionSegue, sender: self)
      } else {
        let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
      }
    }
    
  }

  func newQuestionSelected() {
    let newQuestionSegue = ModelInterface.sharedInstance.segueToCreateNewQuestion()
    performSegueWithIdentifier(newQuestionSegue, sender: self)
  }
  
  func resultsButtonSelected(question: Question) {
    sendQuestionText = question.questionText
    sendAIDS = question.AIDS
    sendTime = question.endTimestamp
    sendQID = question.QID
    let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  func refreshQuestions() {
    listOfYourQuestions.removeAll()
    listOfAnsweredQuestions.removeAll()
    listOfUnansweredQuestions.removeAll()
    listOfExpiredQuestions.removeAll()
    addContainerToVC()
  }
  
  
}

