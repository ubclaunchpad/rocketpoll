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
  private var answerIDDictionary = [AnswerText: AnswerID]()
  private var answers: [AnswerText] = []
  private var NumResponsesPerAnswer: [Int] = []
  private var yourAnswerID = ""
  private var yourAnswerText = ""
  private var author = ""
  // Recieved information
  var questionText = ""
  var questionID:QuestionID = ""
  var answerIDs: [AnswerID] = []
  var fromPollUser: Bool = false
  
  
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
    
    if (currentUser == author){
      container?.makeDeleteButtonVisisble()
    }else{
      container?.hideDeleteButton()
    }
    
    //TODO:IPA-125
    ModelInterface.sharedInstance.processAnswerData(answerIDs) { (listofAllAnswers) in
      ModelInterface.sharedInstance.findYourAnswer(self.questionID) { (yourAnswer) in
        self.answerIDDictionary = [AnswerText: AnswerID]()
        self.answers = []
        self.NumResponsesPerAnswer = []
        self.totalNumberOfUserAnswers = 0
        self.correctAnswer = ""
        self.yourAnswerID = yourAnswer
        self.fillInTheFields(listofAllAnswers)
        self.container?.delegate = self
        self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
        self.container?.setQuestionLabelText(self.questionText)
        self.container?.setAnswers(self.answers)
        self.container?.setCorrectAnswer(self.correctAnswer)
        self.container?.setNumberOfResponsesForAnswer(self.NumResponsesPerAnswer)
         self.container?.setYourAnswer(self.yourAnswerText)
        self.container?.resultsTableView.reloadData()
        self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
        
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
    let size = listofAllAnswers.count
    for i in 0 ..< size  {
      let tempAnswer = listofAllAnswers[i].answerText
      if (listofAllAnswers[i].AID == yourAnswerID) {
        yourAnswerText = listofAllAnswers[i].answerText
      }
      
      self.answers.append(tempAnswer)
      self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
      
      if (listofAllAnswers[i].isCorrect == true ) {
        self.correctAnswer = listofAllAnswers[i].answerText
      }
      self.totalNumberOfUserAnswers += listofAllAnswers[i].tally
      
      self.NumResponsesPerAnswer.append(listofAllAnswers[i].tally)
      
    }
    
  }
  
  func deleteQuestion(){
    ModelInterface.sharedInstance.stopTimer(questionID)
    ModelInterface.sharedInstance.removeQuestion(questionID)
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
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
}


