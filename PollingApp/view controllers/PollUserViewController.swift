//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

final class PollUserViewController: UIViewController {
    private var answerIDDictionary = [Answer: AnswerID]()
    private var min:Int = 0
    private var sec = 0
    private var seconds = 0
    private var timer = NSTimer()
    var answers:[Answer] = []
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
        
        questionID = ModelInterface.sharedInstance.getQuestionID()
        let questionText: Question = ModelInterface.sharedInstance.getQuestion(questionID)
        answerIDs = ModelInterface.sharedInstance.getListOfAnswerIDs(questionID)
        
        container?.setQuestionText(questionText)
        container?.delegate = self
        answers = getAnswers(answerIDs)
        container?.setAnswers(answers)
        createTimer(ModelInterface.sharedInstance.getCountdownSeconds())
    }
    
    func getAnswers(answerIDs: [AnswerID]) -> [Answer] {
        // Changes the list of answerIDs to list of answers
        var answers = [String]()
        var temp_answer:Answer
        
        for answerID in answerIDs {
            temp_answer = ModelInterface.sharedInstance.getAnswer(answerID)
            answers.append(temp_answer)
            answerIDDictionary[temp_answer] = answerID
        }
        return answers
    }
    
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
    func answerSelected(answer: Answer) {
        if let selectedAnswerID = answerIDDictionary[answer] {
            ModelInterface.sharedInstance.setUserAnswer(questionID, answerID: selectedAnswerID)
            print("selected answer is: \(answer) ,printed from viewController")
            //let nextRoom = ModelInterface.sharedInstance.SEGUE_GETTER_FUNCTION(selectedRoomID) //implement these function once segue function is added to model 
            //performSegueWithIdentifier(nextRoom, sender: self)

        }
    }
    
}
