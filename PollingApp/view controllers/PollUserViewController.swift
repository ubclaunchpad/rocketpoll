//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
