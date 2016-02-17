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
        saveDummyQuestion();
        
    
    }
    
    func saveDummyQuestion() {
        //creates and saves a dummy question string to which is later inserted into the header text field
        let defaults = NSUserDefaults.standardUserDefaults();
        let DummyQuestion = "Do you understand?";
        defaults.setValue(DummyQuestion, forKey: "dummyQuestion");
    }

    
    func setup() {
        // add your container class to view
        container = PollUserViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        //retrieve Question String and store into questionText variable
       // let defaults = NSUserDefaults.standardUserDefaults();
        //let questionText:Question = defaults.stringForKey("dummyQuestion")!;
        let questionText = "do you understand";
        let answers = ["yes","no"];
        
        //Run the setHeaderText Function
        container?.setHeaderText(questionText);
        container?.setAnswers(answers);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
