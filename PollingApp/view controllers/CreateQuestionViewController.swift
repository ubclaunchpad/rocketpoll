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
        
        setup()
    }
  
    func setup() {
        // add your container class to view
        container = CreateQuestionContainerView.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }

    
}





extension CreateQuestionViewController: CreateQuestionViewContainerDelegate {
  
    func submitButtonPressed(question: Question, answerArray: [String] ) {
    let nextRoom = ModelInterface.sharedInstance.segueToAdminScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }
  func backButtonPressed() {
   
    let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  }

}
