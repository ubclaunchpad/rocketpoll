//
//  CreateQuestionViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CreateQuestionViewController: UIViewController{
  
  
  private var sendAIDS = [AnswerID]()
  private var sendTime = 0.0
  private var sendQuestionText = "";
  private var sendQID = "";
  
  var container: CreateQuestionContainerView?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(CreateQuestionViewController.dismissKeyboards))
    view.addGestureRecognizer(tap)
    
    addContainerToVC()
  }
  
  //MARK: - Helper Functions
  func addContainerToVC() {
    container = CreateQuestionContainerView.instanceFromNib(
      CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    container?.delegate = self
    view.addSubview(container!)
  }
  
  func dismissKeyboards() {
    view.endEditing(true)
  }
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == ModelInterface.sharedInstance.segueToAdminScreen()) {
      let viewController:PollAdminViewController = segue.destinationViewController as! PollAdminViewController
      viewController.answerIDs = sendAIDS
      viewController.questionText = sendQuestionText
      viewController.questionID = sendQID
      viewController.timerQuestion = sendTime
    }
  }
  
  
}

extension CreateQuestionViewController: CreateQuestionViewContainerDelegate {
  
  func submitButtonPressed(question: QuestionText, answerArray: [AnswerID], questionDuration: Int){
    //TODO: move answerID generation in createNewQuestion(_)
    let questionObject = ModelInterface.sharedInstance.createNewQuestion(question, questionDuration: questionDuration)
    let answerIDs =  ModelInterface.sharedInstance.createAnswerIDs(
      questionObject.QID, answerText: answerArray)
    questionObject.AIDS = answerIDs
    ModelInterface.sharedInstance.setCorrectAnswer(answerIDs[0], isCorrectAnswer: true);
    
    self.sendAIDS = answerIDs
    self.sendQuestionText = question
    self.sendQID = questionObject.QID
    self.sendTime = questionObject.endTimestamp
    let nextRoom = ModelInterface.sharedInstance.segueToAdminScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  
  func backButtonPressed() {
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  
  //TODO: IPA-120
  
  func checksInput (question:String, A1:String, A2:String,  A3:String,A4:String, timerWasSet:Bool) -> Bool {
    if((question == "") || (A1 == "") || (A2 == "") || (A3 == "") || (A4 == "") || (timerWasSet == false)) {
      let alert = UIAlertController(title: "\(alertMessages.emptyQuestions)", message:"",

                                    preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)",
        style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return true
    }
    return false
  }  
}
