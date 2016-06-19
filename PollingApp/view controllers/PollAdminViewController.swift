//
//  PollAdminViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.


import UIKit



final class PollAdminViewController: UIViewController {
    
    private var answerIDDictionary = [String: AnswerID]()
    private var min:Int = 0
    private var sec = 0
    private var seconds = 0
    private var timer = NSTimer()
    var answers:[String] = []
    var correctAnswers:[String] = []
    var sumuserresults = 0;
    
    var answerIDs:[AnswerID] = []
    var numsubmitforeachAns:[[NSString:Int]] = [[:]]
    
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
        container?.delegate = self
        questionID = ModelInterface.sharedInstance.getSelectedQuestion().QID
        answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
        let questionText: String = ModelInterface.sharedInstance.getSelectedQuestion().questionText
        ModelInterface.sharedInstance.processAnswerData(answerIDs) { (listofAllAnswers) in
           
            let size = listofAllAnswers.count
            for i in 0 ..< size  {
                let tempAnswer = listofAllAnswers[i].getAnswerText()
                self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
                self.answers.append(tempAnswer)
                if (listofAllAnswers[i].isCorrect) {
                    self.correctAnswers.append(tempAnswer)
                }
                else {
                    self.correctAnswers.append("not correct")
                }
            }
             self.container?.setAnswers(self.answers)
             self.container?.setCorrectAnswers(self.correctAnswers)
            self.container?.AnswerTable.reloadData()
        }
        
        
        sumuserresults = ModelInterface.sharedInstance.getSumOfUsersThatSubmittedAnswers(questionID)
        
        container?.setQuestionText(questionText)
 

        createTimer(ModelInterface.sharedInstance.getCountdownSeconds())
        
        
    }
    
    
    func getnumsubmitforeachAns(answerIDs: [AnswerID], questionID: QuestionID) {
        var temp = 0;
        for answerID in answerIDs {
            temp = ModelInterface.sharedInstance.getNumberOfUsersThatGaveThisAnswer(questionID, answerID: answerID)
            numsubmitforeachAns.append([answerID:temp])
        }
        
    }
    
    
    
    
//    // get all the answers and answers that are correct
//    func getAnswers(answerIDs: [AnswerID])   {
//        // Changes the list of answerIDs to list of answers
//        var temp_answer:Answer
//        
//        for answerID in answerIDs {
//            temp_answer = ModelInterface.sharedInstance.getAnswer(answerID)
//            
//            if (ModelInterface.sharedInstance.isCorrectAnswer(answerID)) {
//                correctAnswers.append(temp_answer)
//            }
//            else {
//                correctAnswers.append("notCorrect")
//            }
//            
//            answers.append(temp_answer)
//            answerIDDictionary[temp_answer] = answerID
//        }
//        
//    }
    
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



extension PollAdminViewController: PollAdminViewContainerDelegate {
    
    func segueToResult() {
        let nextRoom =  ModelInterface.sharedInstance.segueToResultsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
        print("SegueToResult");
    }
    
    func segueToCampaign() {
        let nextRoom =  ModelInterface.sharedInstance.segueToQuestionsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
        print("SegueToCampaign");
    }
}
