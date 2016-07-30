//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  
  func submitButtonPressed(question: QuestionText, answerArray: [AnswerID], correctAnswer: Int, questionDuration: Int)
  func backButtonPressed()
  func checksInput (question:QuestionText?, A1:AnswerText?, A2:AnswerText?,  A3:AnswerText?, A4:AnswerText?, correctAnswer:Int) -> Bool
  func shiftView()
  func checkDuplicateAnswer(answers: [String]) -> Bool

}

class CreateQuestionContainerView: UIView {
  
  @IBOutlet weak var setTimerButton: UIButton!

  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var Submit: UIButton!
  
  var delegate: CreateQuestionViewContainerDelegate?
  
  @IBOutlet weak var questionInputText: UITextField!
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var setTimerView: UIView!
  
  var time: Int = 0;
  
  var answerIdentifier:[Int] = [1, 2, 3, 4]
  var answers = [Int: String]()
  var correctAnswer:Int = 0
  
  var currentTimeAway:Int = 1
  var endTime:NSDate?
  
  @IBOutlet weak var endTimerLabel: UIButton!
  
  @IBAction func setTimerButtonPressed(sender: AnyObject) {

    setTimerView.hidden = false
    
    delegate?.shiftView()
    setEndTimerLabel()
  }
  
  @IBAction func SubmitPress(sender: AnyObject) {
    let question = questionInputText.text;
    let A1 = answers[1]
    let A2 = answers[2]
    let A3 = answers[3]
    let A4 = answers[4]
    
    if ((delegate?.checksInput(question, A1: A1, A2: A2, A3: A3, A4: A4, correctAnswer: correctAnswer)) == true) {
      return
    } else if ((delegate?.checkDuplicateAnswer([A1!, A2!, A3!, A4!])) == true) {
      return
    }
    
    let Answers = [A1!, A2!, A3!, A4!];
    time = currentTimeAway
    
    delegate?.submitButtonPressed(question!,answerArray: Answers, correctAnswer: correctAnswer, questionDuration: time);
    
    
  }
  
  @IBAction func changeTime(sender: UIButton) {
    currentTimeAway += setTimerValues[sender.tag]
    if currentTimeAway < 0 {
      currentTimeAway = 1
    }
    setEndTimerLabel()
  }
  
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    delegate?.backButtonPressed()
  }
  
  func setEndTimerLabel() {
    endTime = calendar.dateByAddingUnit(.Minute, value: currentTimeAway, toDate: NSDate(), options: [])!
    let day = currentTimeAway / UITimeConstants.oneDayinMinutes
    let hour = (currentTimeAway % UITimeConstants.oneDayinMinutes) / UITimeConstants.oneHourinMinutes
    let minute = currentTimeAway % UITimeConstants.oneHourinMinutes
    let date = endTime!.timeStampAMPM()
    
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
        let detailedDate = endTime!.detailedTimeStamp()
        endTimerLabel.setTitle(StringUtil.fillInString(labelString!, time1: day, time2: hour, time3: minute, date: detailedDate), forState: .Normal)
      } else {
        endTimerLabel.setTitle(StringUtil.fillInString(labelString!, time1: day, time2: hour, time3: minute, date: date), forState: .Normal)

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
      endTimerLabel.setTitle(StringUtil.fillInString(labelString!, time1: hour, time2: minute, date: date), forState: .Normal)
    } else if dateState.count == 1 {
      switch dateState {
      case let dateState where dateState == [true]:
        labelString = UITimeRemaining.timerTextMinute
      case let dateState where dateState == [false]:
        labelString = UITimeRemaining.timerTextMinutes
      default: break
      }
      endTimerLabel.setTitle(StringUtil.fillInString(labelString!, time: minute, date: date), forState: .Normal)
    }
    
//    if currentTimeAway >= UITimeConstants.oneHourinMinutes {
//      if hour > 1 {
//        if minute == 1 {
//          endTimerLabel.setTitle(StringUtil.fillInString(UITimeRemaining.timerTextHoursMinute, time1: hour, time2: minute, date: date), forState: .Normal)
//        } else {
//          endTimerLabel.setTitle(StringUtil.fillInString(UITimeRemaining.timerTextHoursMinutes, time1: hour, time2: minute, date: date), forState: .Normal)
//        }
//      } else if hour == 1{
//        if minute == 1 {
//          endTimerLabel.setTitle(StringUtil.fillInString(UITimeRemaining.timerTextHourMinute, time1: hour, time2: minute, date: date), forState: .Normal)
//        } else {
//          endTimerLabel.setTitle(StringUtil.fillInString(UITimeRemaining.timerTextHourMinutes, time1: hour, time2: minute, date: date), forState: .Normal)
//        }
//      }
//    } else {
//      if minute > 1 {
//        endTimerLabel.setTitle(StringUtil.fillInString(UITimeRemaining.timerTextMinutes, time: minute, date: date), forState: .Normal)
//      } else if minute == 1 {
//        endTimerLabel.setTitle(StringUtil.fillInString(UITimeRemaining.timerTextMinute, time: minute, date: date), forState: .Normal)
//      }
//    }
  }
  
  func hideTimerView() {
    setTimerView.hidden = true
  }
  
  class func instanceFromNib(frame: CGRect) -> CreateQuestionContainerView {
    let view = UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CreateQuestionContainerView
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    view.tableView.separatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2 )
    
    return view
  }
  
}

extension CreateQuestionContainerView: AnswerTableViewCellDelegate {
  
  func updateAnswer(identifier: Int, answer: String) {
    answers[identifier] = answer
    print(answer)
  }
  
  func updateCorrectAnswer(identifier: Int) {
    for cell in tableView.visibleCells {
      let answerCell = cell as! AnswerTableViewCell
      if answerCell.identifier != identifier {
        answerCell.isCorrect = false
      }
    }
    correctAnswer = identifier
  }
  
  func deselectAnswer(identifier: Int) {
    correctAnswer = 0
  }
}

extension CreateQuestionContainerView: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let pollResultsCell = UINib(nibName: "AnswerTableViewCell", bundle: nil)
    tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "answerCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as! AnswerTableViewCell
    cell.identifier = answerIdentifier[indexPath.item]
    cell.delegate = self
    cell.isCorrect = false
    cell.answerField.addTarget(cell, action: #selector(AnswerTableViewCell.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}


