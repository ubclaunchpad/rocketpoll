//
//  FirstViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CampaignsViewController: UIViewController {
    
    var container: CampaignViewContainer?
    private var questionIDDictionary = [Question: QuestionID]()
    
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
        
        let questions = ModelInterface.sharedInstance.getListOfQuestions()
        container?.setQuestions(questions)
//        container?.delegate = self
        
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
    
}


extension CampaignsViewController: CampaignViewContainerDelegate {
    func questionSelected(question: Question) {
        if let questionID = questionIDDictionary[question] {
            print(questionID)
            let questionSegue = ModelInterface.sharedInstance.segueToQuestion()
            performSegueWithIdentifier(questionSegue, sender: self)
            
        }
    }
}

