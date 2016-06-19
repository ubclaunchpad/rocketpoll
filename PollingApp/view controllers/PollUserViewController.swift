//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

final class PollUserViewController: UIViewController {
    private var answerIDDictionary = [AnswerText: AnswerID]()
    private var min:Int = 0
    private var sec = 0
    private var seconds = 0
    private var timer = NSTimer()
    var answers:[AnswerText] = []
    var answerIDs:[AnswerID] = []
    
    private var questionID:QuestionID = ""
    
    var container: PollUserViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        // add your container class to view
        let viewSize = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        container = PollUserViewContainer.instanceFromNib(viewSize)
        view.addSubview(container!)
    
        answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
        ModelInterface.sharedInstance.processAnswerData(answerIDs) { (listofAllAnswers) in
            let size = listofAllAnswers.count
            for i in 0 ..< size  {
                let tempAnswer = listofAllAnswers[i].answerText
                self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
                self.answers.append(tempAnswer)
            }
            self.container?.delegate = self
            self.questionID = selectedQuestion.QID
            let questionText: QuestionText = selectedQuestion.questionText
            self.container?.setQuestionText(questionText)
            self.container?.setAnswers(self.answers)
            self.createTimer(ModelInterface.sharedInstance.getCountdownSeconds())
            self.container?.tableView.reloadData()

        }
    }
    
//    func getAnswers(answerIDs: [AnswerID]) -> [Answer] {
//        // Changes the list of answerIDs to list of answers
//        var answers = [String]()
//        var temp_answer:Answer
//        
//        for answerID in answerIDs {
//            temp_answer = ModelInterface.sharedInstance.getAnswer(answerID)
//            answers.append(temp_answer)
//            answerIDDictionary[temp_answer] = answerID
//        }
//        return answers
//    }
    
    func createTimer (startingTime: Int) {
        seconds = startingTime
        let min_temp:Int = seconds/60
        let sec_temp = seconds-60*(min_temp)
        container?.updateTimerLabel(sec_temp, mins: min_temp)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(PollUserViewController.updateTimer)), userInfo: nil, repeats: true)
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PollUserViewController: PollUserViewContainerDelegate {
    func answerSelected(answer: AnswerText) {
        if let selectedAnswerID = answerIDDictionary[answer] {
            ModelInterface.sharedInstance.setUserAnswer(questionID, answerID: selectedAnswerID)
            print("selected answer is: \(answer) ,printed from viewController")
            let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
            performSegueWithIdentifier(nextRoom, sender: self)

        }
    }
  func backButtonPushed() {
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
}
