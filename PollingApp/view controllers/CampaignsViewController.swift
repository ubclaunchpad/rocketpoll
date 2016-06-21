//
//  FirstViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
import Firebase

class CampaignsViewController: UIViewController {
    
    private var questionIDDictionary = [QuestionText: QuestionID]()
    private var QIDToAIDSDictionary = [QuestionID:[AnswerID]]()
    private var QIDToAuthorDictionary = [QuestionID: Author]()
    private var questions = [QuestionText]();
    private var authors = [Author]();
    private var questionsAnswered = [Bool]();
    
    
    var container: CampaignViewContainer?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentUser)
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        container = CampaignViewContainer.instancefromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        ModelInterface.sharedInstance.processQuestionData { (listofAllQuestions) in
         
            self.fillInTheFields(listofAllQuestions)
            let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
            let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
            
            self.container?.setRoomNameTitle(roomName)
            self.container?.delegate = self
            self.container?.setQuestions(self.questions)
            self.container?.setQuestionAnswered(self.questionsAnswered)
            self.container?.tableView.reloadData()
        }
    }

    
    func fillInTheFields (listofAllQuestions:[Question]) {
        let size = listofAllQuestions.count
        for i in 0 ..< size  {
            self.questions.append(listofAllQuestions[i].questionText)
            self.authors.append(listofAllQuestions[i].author)
            self.questionsAnswered.append(true)
            self.questionIDDictionary[listofAllQuestions[i].questionText] = listofAllQuestions[i].QID
            self.QIDToAIDSDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].AIDS
            self.QIDToAuthorDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].author
        }
    }
}


extension CampaignsViewController: CampaignViewContainerDelegate {
    func questionSelected(question: QuestionText) {
        if let questionID = questionIDDictionary[question] {
            print(question)
            let AIDS = QIDToAIDSDictionary[questionID]!
            let author = QIDToAuthorDictionary[questionID]!
            if (author == currentUser) {
                ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author)
                let nextRoom = ModelInterface.sharedInstance.segueTotoPollAdminVCFromCampaign()
                performSegueWithIdentifier(nextRoom, sender: self)

            } else {
            
                ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author)
                let questionSegue = ModelInterface.sharedInstance.segueToQuestion()
                performSegueWithIdentifier(questionSegue, sender: self)
            }
          
        }
    }
    func newQuestionSelected() {
        let newQuestionSegue = ModelInterface.sharedInstance.segueToCreateNewQuestion()
        performSegueWithIdentifier(newQuestionSegue, sender: self)
    }
  
    func resultsButtonSelected(question: QuestionText) {
    if let questionID = questionIDDictionary[question] {
        
        let AIDS = QIDToAIDSDictionary[questionID]!;
        let author = QIDToAuthorDictionary[questionID]!;
        ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author)
        let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
    }
  }
  
}

