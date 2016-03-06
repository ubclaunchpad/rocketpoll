//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

var seconds = 0;
var timer = NSTimer();
// TODO: Cyros and Milton are working here

class PollUserViewController: UIViewController {
    
    
    var container: PollUserViewContainer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
    }
    
    
    func setup() {
        
        
        
        // add your container class to view
        container = PollUserViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        // TODO: Add model references
        let questionText: Question = "Do you understand?";      // .getQuestion()
        let answers = ["Yes","No", "Somewhat", "Definitely"];   // .getListofAnswersIDs
        
        //Run the setHeaderText Function
        container?.setQuestionText(questionText);
        container?.setAnswers(answers)
        
        //Set arbitrary initial time
        createTimer(40); //.getCountdownSeconds
        
        
    }
    
    func createTimer (startingTime: Int) {
        seconds = startingTime;
        container?.updateTimerLabel(seconds)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("updateTimer"), userInfo: nil, repeats: true);
        
    }
    
    
    
    func updateTimer (){
        
        if(seconds>0){
        seconds--
        container?.updateTimerLabel(seconds)
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
