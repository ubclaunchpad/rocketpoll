//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

// TODO: Cyros and Milton are working here

final class PollUserViewController: UIViewController {
    private var answerIDs = [AnswerID: Answer]()
    
    var min:Int = 0;
    var sec = 0;
    var seconds = 0;
    var timer = NSTimer();
    var container: PollUserViewContainer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
    }
    
    func setup() {
        
        // add your container class to view
        container = PollUserViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        // TODO: Find actual QuestionID
        let questionText: Question = ModelInterface.sharedInstance.getQuestion("QuestionID")  // .getQuestion()
        let answerIDs = ModelInterface.sharedInstance.getListOfAnswerIDs("QuestionID")    //with random question ID
        
        //Run the setHeaderText Function
        container?.setQuestionText(questionText);
        container?.delegate = self
        //container?.setAnswers(answers)
        
        let answers = getAnswers(answerIDs)
        container?.populateAnswerViews(answers)
        
        //Set initial time
        createTimer(ModelInterface.sharedInstance.getCountdownSeconds());
        
        
    }
    
    func getAnswers(answerIDs: [AnswerID]) -> [Answer] {
        //        Changes the list of answerIDs to list of answers
        var answers = [String]();
        for answer in answerIDs {
            answers.append(ModelInterface.sharedInstance.getAnswer(answer))
        }
        return answers
    }
    
    func createTimer (startingTime: Int) {
        seconds = startingTime;
        let min_temp:Int = seconds/60;
        let sec_temp = seconds-60*(min_temp);
        container?.updateTimerLabel(sec_temp, mins: min_temp)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("updateTimer"), userInfo: nil, repeats: true);
        
    }
    
    
    
    func updateTimer (){
        
        if(seconds>0){
        seconds--
            min = seconds/60;
            sec = seconds - 60*min;
        container?.updateTimerLabel(sec,mins: min)
        }else{
            timer.invalidate();
            //SEGUE to next view
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension PollUserViewController: PollUserViewContainerDelegate {
    func answerSelected(answer: Answer) {
        //
    }
    
}
