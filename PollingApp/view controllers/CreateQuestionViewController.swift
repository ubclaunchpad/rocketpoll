//
//  CreateQuestionViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit


class CreateQuestionViewController: UIViewController {
    
    var container: CreateQuestionContainerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateQuestionViewController.dismissKeyboards))
        view.addGestureRecognizer(tap)
        
        
        setup()
    }
    
    func setup() {
        // add your container class to view
        container = CreateQuestionContainerView.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
    
    
    func dismissKeyboards() {
        view.endEditing(true)
    }
    
}





extension CreateQuestionViewController: CreateQuestionViewContainerDelegate {
    
    
    func submitButtonPressed(question: Question, answerArray: [String] ) {
        let nextRoom = ModelInterface.sharedInstance.segueToAdminScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
        
        //sends question string to firebase. firebase generates unique id corresponding to question
        let questionID = ModelInterface.sharedInstance.setNewQuestion(question)
        let answerIDs =  ModelInterface.sharedInstance.setAnswerIDS(questionID, answerString: answerArray)
        
        ModelInterface.sharedInstance.setCorrectAnswer(answerIDs[0], isCorrectAnswer: true);
        
        
    }
    func backButtonPressed() {
        
        let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
    }
    
    func checksInput (question:String, A1:String, A2:String,  A3:String,A4:String) -> Bool {
        if((question == "") || (A1 == "") || (A2 == "") || (A3 == "") || (A4 == "") ) {
            let alert = UIAlertController(title: "Invalid name", message:"",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok",
                style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return true
        }
        return false
    }
    
}
