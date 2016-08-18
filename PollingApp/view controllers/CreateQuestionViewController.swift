//
//  CreateQuestionViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CreateQuestionViewController: UIViewController, UITextViewDelegate {
  
  
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
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreateQuestionViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreateQuestionViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
    
    addContainerToVC()
    setNavigationBar()
    
    stringFromQuestionDuration(1, endTime: NSDate(), setButtonTitle: (container?.setEndTimerButtonTitle)!)
    container?.endTimerLabel.titleLabel?.textAlignment = NSTextAlignment.Center
    
    container?.setPlaceholderText()
    
    container?.questionInputText.layer.cornerRadius = 5
    container?.questionInputText.layer.borderColor = UIColor(red:0.86, green:0.87, blue:0.87, alpha:1.0).CGColor
    container?.questionInputText.layer.borderWidth = 1
    container?.questionInputText.delegate = self
    
    container?.questionInputText.layer.borderWidth = 0
    container?.questionInputText.layer.cornerRadius = 0
    container?.questionInputText.textContainer.lineFragmentPadding = 0
    container?.questionInputText.textContainerInset = UIEdgeInsetsZero;
    
  }
  
  func setNavigationBar() {
    self.title = "ASK"
    let submitButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateQuestionViewController.submitQuestion))
    self.navigationItem.rightBarButtonItem = submitButton
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if self.view.window?.frame.origin.y != 0 || self.container!.AnswersVerticalSpacing.constant != 55 {
      self.container!.AnswersVerticalSpacing.constant = 55

      UIView.animateWithDuration(0.2, animations: {
        self.view.window?.frame.origin.y = 0
        self.view.layoutIfNeeded()
        self.container!.setTimerView.alpha = 0
      })
      
    }
  }
  
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    let currentText = textView.text ?? ""
    guard let stringRange = range.rangeForString(currentText) else { return false }
    
    let changedText = currentText.stringByReplacingCharactersInRange(stringRange, withString: text)
    
    let newText:NSString = textView.text
    let updatedText = newText.stringByReplacingCharactersInRange(range, withString:text)
    
    // If updated text view will be empty, add the placeholder
    // and set the cursor to the beginning of the text view
    if updatedText.isEmpty {
      
      textView.text = placeholders.question
      textView.textColor = colors.placeholderTextColor
      textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
      container?.setCharactersLeftLabel(140)
      return false
    }
      
      // Else if the text view's placeholder is showing and the
      // length of the replacement string is greater than 0, clear
      // the text view and set its color to black to prepare for
      // the user's entry
    else if textView.textColor == colors.placeholderTextColor && !text.isEmpty {
      textView.text = nil
      textView.textColor = colors.textColor
    }
    
    return changedText.characters.count <= 140
  }
  
  func textViewDidChange(textView: UITextView){
    let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    if newSize.height > 35 {
      container?.questionHeight.constant = newSize.height
    }
    print(textView.text.characters.count)
    if textView.textColor == colors.placeholderTextColor || textView.text.characters.count == 0 {
      container?.setCharactersLeftLabel(140)
    } else {
      container?.setCharactersLeftLabel(140 - textView.text.characters.count)
    }
  }
  
  func textViewDidChangeSelection(textView: UITextView) {
    if self.view.window != nil {
      if textView.textColor == colors.placeholderTextColor {
        textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
      }
    }
  }
  
  func submitQuestion() {
    let question = container?.questionInputText.text
    
    guard question != "" else {
      showAlertController(alertMessages.emptyQuestions)
      return
    }
    guard !StringUtil.containsBadCharacters(question!) else {
      showAlertController(alertMessages.symbolQuestion)
      return
    }
    
    let answers: [AnswerText] = (container?.answers)!
    for answer in answers {
      guard answer != "" else {
        showAlertController(alertMessages.emptyAnswer)
        return
      }
    }
    for answer in answers {
      guard !StringUtil.containsBadCharacters(answer) else {
        showAlertController(alertMessages.symbolAnswer)
        return
      }
    }
    guard StringUtil.uniqueString(answers) == true else {
      showAlertController(alertMessages.duplicateAnswer)
      return
    }
    guard container?.correctAnswer != -1 else {
      showAlertController(alertMessages.noCorrectAnswer)
      return
    }
    
    container?.time = (container?.currentTimeAway)!
    
    submitButtonPressed(question!,answerArray: answers, correctAnswer: (container?.correctAnswer)!, questionDuration: (container?.time)!)
  }
  
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
  
  func showAlertController(title: String) {
    let alert = UIAlertController(title: "\(title)", message:"", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "\(alertMessages.confirm)",
      style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
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
  
  func keyboardWillShow(notification: NSNotification) {
    if container?.questionInputText.isFirstResponder() == true {
      if self.view.window?.frame.origin.y != 0 {
        UIView.animateWithDuration(0.2, animations: {
          self.view.window?.frame.origin.y = 0
        })
      }
    }
    let cells = container?.tableView.visibleCells as! [AnswerTableViewCell]!
    for i in 0...cells.count - 1 {
      if i >= 2 && cells[i].answerField.editing {
        if self.view.window?.frame.origin.y > -100 {
          self.view.window?.frame.origin.y -= 100
          return
        }
      } else {
        if self.view.window?.frame.origin.y != 0 {
          UIView.animateWithDuration(0.2, animations: {
            self.view.window?.frame.origin.y = 0
          })
        }
      }
    }
  }
  func keyboardWillHide(notification: NSNotification) {
    if self.view.window?.frame.origin.y != 0 {
      self.view.window?.frame.origin.y = 0
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == ModelInterface.sharedInstance.segueToAdminScreen()) {
      let viewController:PollAdminViewController = segue.destinationViewController as! PollAdminViewController
      viewController.answerIDs = sendAIDS
      viewController.questionText = sendQuestionText
      viewController.questionID = sendQID
      viewController.timerQuestion = sendTime
      viewController.fromCreate = true
    }
  }
}

extension CreateQuestionViewController: CreateQuestionViewContainerDelegate {
  
  //TODO: IPA-120
  
  func shiftView() {
    UIView.animateWithDuration(0.2, animations: {
      self.view.window?.frame.origin.y = -90
    })
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

extension NSRange {
  func rangeForString(str: String) -> Range<String.Index>? {
    guard location != NSNotFound else { return nil }
    return str.startIndex.advancedBy(location) ..< str.startIndex.advancedBy(location + length)
  }
}
