//
//  PollResultsViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

// TODO: James is working here

class PollResultsViewController: UIViewController {
  
  private var questionID:QuestionID = ""
  var container: PollResultsViewContainer?
  private var answers:[Answer] = []
  private var answerIDs:[AnswerID] = []
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    
    questionID = ModelInterface.sharedInstance.getQuestionID()
    let questionText: Question = ModelInterface.sharedInstance.getQuestion(questionID)
    answerIDs = ModelInterface.sharedInstance.getListOfAnswerIDs(questionID)
    container = PollResultsViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
    
    container?.setQuestionLabelText(questionText)
  }
}

