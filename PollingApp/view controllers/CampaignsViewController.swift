//
//  FirstViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CampaignsViewController: UIViewController {
    
    private var questionIDDictionary = [Question: QuestionID]()
    var container: CampaignViewContainer?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        container = CampaignViewContainer.instancefromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        let questions = getQuestions(ModelInterface.sharedInstance.getListOfQuestions())
        let questionAnswered = isQuestionAnswered(ModelInterface.sharedInstance.getListOfQuestions())
        let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
        let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
        container?.delegate = self
        container?.setQuestions(questions)
        container?.setQuestionAnswered(questionAnswered)
        container?.setRoomNameTitle(roomName)
    }
    
    func getQuestions(questionIDs: [Question]) -> [Question] {
        var temp_questions = [Question]()
        var temp_question:Question
        for questionID in questionIDs {
            temp_question = ModelInterface.sharedInstance.getQuestion(questionID)
            temp_questions.append(temp_question)
            questionIDDictionary[temp_question] = questionID
        }
        return temp_questions
    }
    
    func isQuestionAnswered(questionIDs: [Question]) -> [Bool] {
        var temp_question_Answered = [Bool]()
        for questionID in questionIDs {
            let isQuestionAnswered = ModelInterface.sharedInstance.isQuestionAnswered(questionID)
            temp_question_Answered.append(isQuestionAnswered)
        }
        return temp_question_Answered
    }
    
}


extension CampaignsViewController: CampaignViewContainerDelegate {
    func questionSelected(question: Question) {
        if let questionID = questionIDDictionary[question] {
            print(questionID)
            let questionSegue = ModelInterface.sharedInstance.segueToQuestion()
            performSegueWithIdentifier(questionSegue, sender: self)
          
        }
    }
    func newQuestionSelected() {
        let newQuestionSegue = ModelInterface.sharedInstance.segueToCreateNewQuestion()
        performSegueWithIdentifier(newQuestionSegue, sender: self)
    }
  
  func resultsButtonSelected() {
    let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
    performSegueWithIdentifier(nextRoom, sender: self)
  print("perform segue")
  }
  
}

