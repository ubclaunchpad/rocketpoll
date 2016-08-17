//
//  PollResultsViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
import Firebase

class PollResultsViewController: UIViewController {
  private var correctAnswer: AnswerText = ""
  var totalNumberOfUserAnswers: Int = 0
  
  private var answers:[Answer] = []
  private var yourAnswerID = ""
  private var yourAnswerText = ""
  private var author = ""
  
  // Recieved information
  var questionText = ""
  var questionID:QuestionID = ""
  var answerIDs: [AnswerID] = []
  var fromPollUser: Bool = false
  
  
  // Information to send
  
  var sendAnswer:Answer?
  var sendQuestionText:QuestionText = ""
  
  
  var container: PollResultsViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerToVC()
    if fromPollUser {
      setNavigationBar()
    }
    self.title = "RESULTS"
  }
  
  func addContainerToVC() {
    
    
    container = PollResultsViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
    
    //TODO:IPA-125
    ModelInterface.sharedInstance.processAnswerData(answerIDs) { (listofAllAnswers) in
      ModelInterface.sharedInstance.findYourAnswer(self.questionID) { (yourAnswer) in
        self.answers = []
        self.totalNumberOfUserAnswers = 0
        self.correctAnswer = ""
        self.yourAnswerID = yourAnswer
        
        self.fillInTheFields(listofAllAnswers)
        self.container?.delegate = self
        
        self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
        self.container?.setQuestionLabelText(self.questionText)
        self.container?.setCorrectAnswer(self.correctAnswer)
        self.container?.setYourAnswer(self.yourAnswerText)
        self.container?.setAnswers(self.answers)
    
        self.container?.resultsTableView.reloadData()
        
      }
      
    }
  }
  
  func setNavigationBar() {
    let backItem = UIBarButtonItem(image: UIImage(named: "Back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PollResultsViewController.popSegue))
    navigationItem.leftBarButtonItem = backItem
  }
  
  func popSegue() {
    self.navigationController?.popToViewController((self.navigationController?.viewControllers.first)!, animated: true)
  }
  
  func fillInTheFields (listofAllAnswers: [Answer]) {
    
    answers = listofAllAnswers
    let size = listofAllAnswers.count
    for i in 0 ..< size  {
      if (listofAllAnswers[i].isCorrect == true ) {
        self.correctAnswer = listofAllAnswers[i].answerText
      }
      self.totalNumberOfUserAnswers += listofAllAnswers[i].tally
    }
    
  }
  func deleteQuestion(){
    ModelInterface.sharedInstance.stopTimer(questionID)
    ModelInterface.sharedInstance.removeQuestion(questionID)
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier ==  ModelInterface.sharedInstance.segueToWhoVotedForVCFromResult()) {
      
      let viewController:WhoVotedForViewController = segue.destinationViewController as! WhoVotedForViewController
      
      viewController.selectedAnswer = sendAnswer
      viewController.questionText = questionText
      
    }
  }
}

extension PollResultsViewController: PollResultsViewContainerDelegate {
  func goBackToCampaign() {
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  
  func presentConfirmationVaraible() {
    let deleteAlert = UIAlertController(title: "\(alertMessages.confirmation)", message: "\(alertMessages.confirmationMessage)", preferredStyle: UIAlertControllerStyle.Alert)
    deleteAlert.addAction(UIAlertAction(title: "\(alertMessages.no)", style: .Default, handler: { (action: UIAlertAction!) in deleteAlert.dismissViewControllerAnimated(true, completion: nil)
    }))
    deleteAlert.addAction(UIAlertAction(title: "\(alertMessages.yes)", style: .Cancel, handler: { (action: UIAlertAction!) in
      self.deleteQuestion()
    }))
    presentViewController(deleteAlert, animated: true, completion: nil)
  }
  
  func segueToWhoVotedFor(selectedAnswer:Answer) {
    sendAnswer = selectedAnswer
    
    let nextRoom = ModelInterface.sharedInstance.segueToWhoVotedForVCFromResult()
    performSegueWithIdentifier(nextRoom, sender: self)
    
  }
}


