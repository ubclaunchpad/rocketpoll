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

  private var sendQuestion:Question?
  
  var container: CampaignViewContainer?
  
  var segmentedControlIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerToVC()
    Log.debug("loaded campaign view")
    setNavigationBar()
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
    let submitButton = UIBarButtonItem(title: "Ask ", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CampaignsViewController.newQuestionSelected))
    self.navigationItem.rightBarButtonItem = submitButton
    
    let refreshButton = UIBarButtonItem(image: UIImage(named: "Refresh"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CampaignsViewController.refreshQuestions))
    self.navigationItem.leftBarButtonItem = refreshButton
    
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
      container?.setTableCells(listOfUnansweredQuestions + listOfAnsweredQuestions)
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
      let tempQuestion = DateUtil.setExpirationDate(listofAllQuestions[i])
      
      if (listofAllQuestions[i].author == currentUser) {
        listOfYourQuestions.append(listofAllQuestions[i])
      } else if tempQuestion.isExpired {
        listOfExpiredQuestions.append(tempQuestion)
      } else {
        if (listOfAnsweredQIDs.contains(listofAllQuestions[i].QID)) {
          listOfAnsweredQuestions.append(listofAllQuestions[i])
        } else if (!listOfYourQuestions.contains(tempQuestion) &&
          !listOfAnsweredQuestions.contains(tempQuestion)) {
          listOfUnansweredQuestions.append(tempQuestion)
        }
      }
    }
    
    self.container?.delegate = self
    
    switch segmentedControlIndex {
    case 0:
      container?.setTableCells(listOfYourQuestions)
    case 1:
      container?.setTableCells(listOfUnansweredQuestions + listOfAnsweredQuestions)
    case 2:
      container?.setTableCells(listOfExpiredQuestions)
    default: break
    }
    container?.answeredQuestions = listOfAnsweredQIDs
    self.container?.tableView.reloadData()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    switch segue.identifier!  {
    case ModelInterface.sharedInstance.segueTotoPollAdminVCFromCampaign():
      let viewController:PollAdminViewController = segue.destinationViewController as! PollAdminViewController
      viewController.recievedQuestion = (sendQuestion)!
      break
    case ModelInterface.sharedInstance.segueToQuestion():
      let viewController:PollUserViewController = segue.destinationViewController as! PollUserViewController
      viewController.answerIDs = (sendQuestion?.AIDS)!
      viewController.questionID = (sendQuestion?.QID)!
      viewController.questionText = (sendQuestion?.questionText)!
      break
    case ModelInterface.sharedInstance.segueToResultsScreen():
      let viewController:PollResultsViewController = segue.destinationViewController as! PollResultsViewController
      viewController.questionID = (sendQuestion?.QID)!
      viewController.questionText = (sendQuestion?.questionText)!
      viewController.answerIDs = (sendQuestion?.AIDS)!
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
    sendQuestion = question
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
    sendQuestion = question
    let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  
  func refreshQuestions() {
    listOfYourQuestions.removeAll()
    listOfAnsweredQuestions.removeAll()
    listOfUnansweredQuestions.removeAll()
    listOfExpiredQuestions.removeAll()
    ModelInterface.sharedInstance.processQuestionData { (listofAllQuestions) in
      ModelInterface.sharedInstance.getListOfQuestionsUserAnswered({ (listOfAnsweredQIDs) in
        self.fillInTheFields(listofAllQuestions, listOfAnsweredQIDs:listOfAnsweredQIDs)
      })
      
    }
  }
  
  
}

