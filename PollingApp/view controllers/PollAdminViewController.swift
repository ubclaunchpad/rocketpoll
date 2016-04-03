//
//  PollAdminViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit



final class PollAdminViewController: UIViewController {

    private var answerIDDictionary = [Answer: AnswerID]()
    private var min:Int = 0
    private var sec = 0
    private var seconds = 0
    private var timer = NSTimer()
    var answers:[Answer] = []
    var correctAnswers:[Answer] = []
    
    var answerIDs:[AnswerID] = []

    private var questionID:QuestionID = ""
    
    var container: PollAdminViewContainer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        // add your container class to view
        container = PollAdminViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
       questionID = ModelInterface.sharedInstance.getQuestionID()
        let questionText: Question = ModelInterface.sharedInstance.getQuestion(questionID)
       answerIDs = ModelInterface.sharedInstance.getListOfAnswerIDs(questionID)

     container?.setQuestionText(questionText)
        
        
        self.getAnswers(answerIDs)
        container?.setAnswers(answers)
        container?.setCorrectAnswers(correctAnswers)
        
     createTimer(ModelInterface.sharedInstance.getCountdownSeconds())
        
        
    }
    
    
    // get answers and answers that are correct
    func getAnswers(answerIDs: [AnswerID])   {
        // Changes the list of answerIDs to list of answers
        var temp_answer:Answer
        
        for answerID in answerIDs {
            temp_answer = ModelInterface.sharedInstance.getAnswer(answerID)
    
            if (ModelInterface.sharedInstance.isCorrectAnswer(answerID)) {
                correctAnswers.append(temp_answer)
            }
            else {
                correctAnswers.append("notCorrect")
            }
            
            answers.append(temp_answer)
            answerIDDictionary[temp_answer] = answerID
        }

    }
    
    func createTimer (startingTime: Int) {
        seconds = startingTime
        let min_temp:Int = seconds/60
        let sec_temp = seconds-60*(min_temp)
        container?.updateTimerLabel(sec_temp, mins: min_temp)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(PollUserViewController.updateTimer)),userInfo: nil, repeats: true)

  }
    
    func updateTimer() {
        if(seconds>0) {
            seconds -= 1
            min = seconds/60
            sec = seconds - 60*min
            container?.updateTimerLabel(sec,mins: min)
        } else {
            timer.invalidate()
            // TODO: SEGUE to next view
        }
}

}
