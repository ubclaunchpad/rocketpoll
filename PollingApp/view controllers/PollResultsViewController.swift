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
  private var totalNumberOfUserAnswers: Int = 0
  
  private var answers:[Answer] = []
  private var yourAnswerID = ""
  private var yourAnswerText = ""
  private var author = ""
  private var firstTime = true
  // Recieved information
  var recievedQuestion:Question?
  
  var fromTimerEnd: Bool = false
  
  var isTheQuestionExpired:Bool = true
  // Information to send
  
  var sendAnswer:Answer?
  var sendQuestionText:QuestionText = ""
  
  var container: PollResultsViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if fromTimerEnd || isTheQuestionExpired {
      setNavigationBar()
    }
    addContainerToVC()
    self.title = "RESULTS"
    self.container?.resultsTableView.hidden = false
    self.container?.resultsTableView.reloadData()
    
  }
  
  override func viewDidAppear(animated: Bool) {
    self.title = "RESULTS"
    self.container?.resultsTableView.hidden = false
    self.container?.resultsTableView.reloadData()
  }
  
  func addContainerToVC() {
    container = PollResultsViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
    
    //TODO:IPA-125
    ModelInterface.sharedInstance.processAnswerData((recievedQuestion?.AIDS)!) { (listofAllAnswers) in
      ModelInterface.sharedInstance.findYourAnswer((self.recievedQuestion?.QID)!) { (yourAnswer) in
        if listofAllAnswers.isEmpty {
          let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
          self.performSegueWithIdentifier(nextRoom, sender: self)
        } else {
          
          self.answers = []
          self.totalNumberOfUserAnswers = 0
          self.correctAnswer = ""
          self.yourAnswerID = yourAnswer
          self.yourAnswerText = ""
          self.fillInTheFields(listofAllAnswers)
          self.container?.delegate = self
          
          self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
          self.container?.setQuestionLabelText((self.recievedQuestion?.questionText)!)
          self.container?.setCorrectAnswer(self.correctAnswer)
          self.container?.setYourAnswer(self.yourAnswerText)
          self.container?.setAnswers(self.answers)
          self.container?.setIsQuestionExpired(self.isTheQuestionExpired)
          self.container?.resultsTableView.hidden = true
          self.container?.resultsTableView.reloadData()
          self.container?.resultsTableView.reloadData()
          if (self.firstTime) {
            sleep(1)
            self.firstTime = false
          }
          self.container?.resultsTableView.hidden = false
        }
        
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
      
      if (listofAllAnswers[i].AID == yourAnswerID) {
        yourAnswerText = listofAllAnswers[i].answerText
      }
      self.totalNumberOfUserAnswers += listofAllAnswers[i].tally
    }
    
  }
  func deleteQuestion(){
    ModelInterface.sharedInstance.stopTimer((self.recievedQuestion?.QID)!)
    ModelInterface.sharedInstance.removeQuestionAndAnswer(recievedQuestion!)
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier ==  ModelInterface.sharedInstance.segueToWhoVotedForVCFromResult()) {
      
      let viewController:WhoVotedForViewController = segue.destinationViewController as! WhoVotedForViewController
      
      viewController.selectedAnswer = sendAnswer
      viewController.questionText = self.recievedQuestion?.questionText
      self.title = ""
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


