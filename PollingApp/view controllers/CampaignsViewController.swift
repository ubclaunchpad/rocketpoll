//
//  FirstViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
import Firebase
import Foundation

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
  
  var segmentedControlIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerToVC()
    Log.debug("loaded campaign view")
    setNavigationBar()
  }
  
  override func viewDidAppear(animated: Bool) {
    refreshQuestions()
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
    //let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
    //let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
    
    container?.delegate = self
    //self.container?.setRoomNameTitle(roomName)
  }
  
  func setNavigationBar() {
    self.title = "QUESTIONS"
    let submitButton = UIBarButtonItem(title: "Ask", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CampaignsViewController.newQuestionSelected))
    self.navigationItem.rightBarButtonItem = submitButton
    
    let segment: UISegmentedControl = UISegmentedControl(items: ["Mine", "New", "Expired"])
    segment.sizeToFit()
    segment.addTarget(self, action: #selector(CampaignsViewController.segmentedControlValueChanged(_:)), forControlEvents:.ValueChanged)
    segment.tintColor = colors.segmentedTint
    segment.selectedSegmentIndex = segmentedControlIndex
    segment.setTitleTextAttributes([NSFontAttributeName: UIFont(name:"Roboto-Regular", size: 13)!],
                                   forState: UIControlState.Normal)
    self.navigationItem.titleView = segment
  }
  
  func segmentedControlValueChanged(segment: UISegmentedControl) {
    switch segment.selectedSegmentIndex {
    case 0:
      container?.setTableCells(listOfYourQuestions)
    case 1:
      container?.setTableCells(listOfUnansweredQuestions + listOfUnansweredQuestions)
    case 2:
      container?.setTableCells(listOfExpiredQuestions)
    default: break
    }
    segmentedControlIndex = segment.selectedSegmentIndex
    container?.tableView.reloadData()
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
    
    switch segmentedControlIndex {
    case 0:
      container?.setTableCells(listOfYourQuestions)
    case 1:
      container?.setTableCells(listOfUnansweredQuestions + listOfUnansweredQuestions)
    case 2:
      container?.setTableCells(listOfExpiredQuestions)
    default: break
    }
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
    let backItem = UIBarButtonItem()
    backItem.title = ""
    navigationItem.backBarButtonItem = backItem
    
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
      let segueToPollAdmin = ModelInterface.sharedInstance.segueTotoPollAdminVCFromCampaign()
      performSegueWithIdentifier(segueToPollAdmin, sender: self)
      
    } else {
      let questionSegue = ModelInterface.sharedInstance.segueToQuestion()
      performSegueWithIdentifier(questionSegue, sender: self)
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

