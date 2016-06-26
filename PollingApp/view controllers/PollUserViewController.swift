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
    private var answers:[AnswerText] = []
    private var answerIDs:[AnswerID] = []
    private var questionText:QuestionText = ""
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
        
        self.answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
        ModelInterface.sharedInstance.processAnswerData(self.answerIDs) { (listofAllAnswers) in
            self.fillInTheFields(listofAllAnswers)
            
            self.container?.delegate = self
            self.container?.setQuestionText(self.questionText)
            self.container?.setAnswers(self.answers)
            self.container?.tableView.reloadData()
            
        }
    }
    
    func fillInTheFields (listofAllAnswers:[Answer]) {
        let size = listofAllAnswers.count
        for i in 0 ..< size  {
            let tempAnswer = listofAllAnswers[i].answerText
            self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
            self.answers.append(tempAnswer)
        }
        self.questionID = selectedQuestion.QID
        self.questionText = selectedQuestion.questionText
        
        
        ModelInterface.sharedInstance.getCountdownSeconds({ (time) -> Void in
            if time > 0 {
                let currentTime = Int(NSDate().timeIntervalSince1970)
                self.createTimer(Int(time) - currentTime)
            }
        })
    }
    
    func createTimer(startingTime: Int) {
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
            let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
            performSegueWithIdentifier(nextRoom, sender: self)
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
