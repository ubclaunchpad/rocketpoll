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
    
    stringFromQuestionDuration(1, endTime: NSDate(), setButtonTitle: (container?.setEndTimerButtonTitle)!)
    container?.endTimerLabel.titleLabel?.textAlignment = NSTextAlignment.Center
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if self.view.window?.frame.origin.y != 0 {
      UIView.animateWithDuration(0.2, animations: {
        self.view.window?.frame.origin.y = 0
      })
      self.container!.hideTimerView()
    }
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
  
  func submitButtonPressed(question: QuestionText, answerArray: [AnswerID], correctAnswer: Int, questionDuration: Int){
    //TODO: move answerID generation in createNewQuestion(_)
    let questionObject = ModelInterface.sharedInstance.createNewQuestion(question, questionDuration: questionDuration)
    let answerIDs =  ModelInterface.sharedInstance.createAnswerIDs(
      questionObject.QID, answerText: answerArray)
    questionObject.AIDS = answerIDs
    ModelInterface.sharedInstance.setCorrectAnswer(answerIDs[correctAnswer], isCorrectAnswer: true);
    
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
  
  func checksInput (question:QuestionText?, answerStrings:[AnswerText], correctAnswer:Int) -> Bool {
    if((question == nil) ||
      checkIfNil(answerStrings) ||
      correctAnswer == -1) {
      let alert = UIAlertController(title: "\(alertMessages.emptyQuestions)", message:"",

                                    preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)",
        style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return true
    }
    return false
  }
  
  func shiftView() {
    UIView.animateWithDuration(0.2, animations: {
      self.view.window?.frame.origin.y = -90
    })
  }
  
  func checkDuplicateAnswer(answers: [String]) -> Bool {
    if !StringUtil.uniqueString(answers) {
      let alert = UIAlertController(title: "\(alertMessages.duplicateAnswer)", message:"",
                                    preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)",
        style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return true
    }
    return false
  }
  
  func checkIfNil(answers:[AnswerText]) -> Bool{
    if answers.count > 0{
      for index in 0...answers.count-1 {
        if answers[index] == "" {
          return true;
        }
      }
    }
    return false;
  }
  
  func stringFromQuestionDuration(currentTimeAway: Int, endTime: NSDate, setButtonTitle: (String) -> ()) {
    let day = currentTimeAway / UITimeConstants.oneDayinMinutes
    let hour = (currentTimeAway % UITimeConstants.oneDayinMinutes) / UITimeConstants.oneHourinMinutes
    let minute = currentTimeAway % UITimeConstants.oneHourinMinutes
    let date = endTime.timeStampAMPM()
    
    var dateState:[Bool] = DateUtil.findDateState(day, hour: hour, minute: minute)
    if day == 0 {
      dateState.removeFirst()
      if hour == 0 {
        dateState.removeFirst()
      }
    }
    
    var labelString:String?
    
    if dateState.count == 3 {
      switch dateState {
      case let dateState where dateState == [true, true, true]:
        labelString = UITimeRemaining.timerTextDayHourMinute
      case let dateState where dateState == [true, false, true]:
        labelString = UITimeRemaining.timerTextDayHoursMinute
      case let dateState where dateState == [true, true, false]:
        labelString = UITimeRemaining.timerTextDayHourMinutes
      case let dateState where dateState == [true, false, false]:
        labelString = UITimeRemaining.timerTextDayHoursMinutes
      case let dateState where dateState == [false, true, true]:
        labelString = UITimeRemaining.timerTextDaysHourMinute
      case let dateState where dateState == [false, false, true]:
        labelString = UITimeRemaining.timerTextDaysHoursMinute
      case let dateState where dateState == [false, true, false]:
        labelString = UITimeRemaining.timerTextDaysHourMinutes
      case let dateState where dateState == [false, false, false]:
        labelString = UITimeRemaining.timerTextDaysHoursMinutes
      default: break
      }
      if day > 1 {
        let detailedDate = endTime.detailedTimeStamp()
        setButtonTitle(StringUtil.fillInString(labelString!, time1: day, time2: hour, time3: minute, date: detailedDate))
      } else {
        setButtonTitle(StringUtil.fillInString(labelString!, time1: day, time2: hour, time3: minute, date: date))
        
      }
    } else if dateState.count == 2 {
      switch dateState {
      case let dateState where dateState == [true, true]:
        labelString = UITimeRemaining.timerTextHourMinute
      case let dateState where dateState == [false, true]:
        labelString = UITimeRemaining.timerTextHoursMinute
      case let dateState where dateState == [true, false]:
        labelString = UITimeRemaining.timerTextHourMinutes
      case let dateState where dateState == [false, false]:
        labelString = UITimeRemaining.timerTextHoursMinutes
      default: break
      }
      setButtonTitle(StringUtil.fillInString(labelString!, time1: hour, time2: minute, date: date))
    } else if dateState.count == 1 {
      switch dateState {
      case let dateState where dateState == [true]:
        labelString = UITimeRemaining.timerTextMinute
      case let dateState where dateState == [false]:
        labelString = UITimeRemaining.timerTextMinutes
      default: break
      }
      setButtonTitle(StringUtil.fillInString(labelString!, time: minute, date: date))
    }
    
  }
}
