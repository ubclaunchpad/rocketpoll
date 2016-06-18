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
    private var listOfAllQuestions = [QuestionC]();
    private var QIDToAIDSDictionary = [String:[String]]()
    private var QIDToAuthorDictionary = [String:String]()
    
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
        ModelInterface.sharedInstance.processQuestionData { (listofAllQuestions) in
            self.listOfAllQuestions = listofAllQuestions
            let size = self.listOfAllQuestions.count
            var questions = [String]();
            var authors = [String]();
            var questionsAnswered = [Bool]();
            for i in 0 ..< size  {
                questions.append(listofAllQuestions[i].getQuestionText())
                authors.append(listofAllQuestions[i].getAuthor())
                questionsAnswered.append(true);
                self.questionIDDictionary[listofAllQuestions[i].getQuestionText()] = listofAllQuestions[i].getQID()
                self.QIDToAIDSDictionary[listofAllQuestions[i].getQID()] = listofAllQuestions[i].getAIDS()
                self.QIDToAuthorDictionary[listofAllQuestions[i].getQID()] = listofAllQuestions[i].getAuthor()
            }
            // Not really important
            
            let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
            let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
            self.container?.setRoomNameTitle(roomName)
            ///////////
            
            
            self.container?.delegate = self
            self.container?.setQuestions(questions)
            self.container?.setQuestionAnswered(questionsAnswered)
           
            self.container?.tableView.reloadData()
        }
        
//        let questions = getQuestions(ModelInterface.sharedInstance.getListOfQuestions())
//        let questionAnswered = isQuestionAnswered(ModelInterface.sharedInstance.getListOfQuestions())
//        let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
//        let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
//        container?.delegate = self
//        container?.setQuestions(questions)
//        container?.setQuestionAnswered(questionAnswered)
//        container?.setRoomNameTitle(roomName)
      
    }
    
//    func getQuestions(questionIDs: [Question]) -> [Question] {
//        var temp_questions = [Question]()
//        var temp_question:Question
//        for questionID in questionIDs {
//            temp_question = ModelInterface.sharedInstance.getQuestion(questionID)
//            temp_questions.append(temp_question)
//            questionIDDictionary[temp_question] = questionID
//        }
//        return temp_questions
//    }
//    
//    func isQuestionAnswered(questionIDs: [Question]) -> [Bool] {
//        var temp_question_Answered = [Bool]()
//        for questionID in questionIDs {
//            let isQuestionAnswered = ModelInterface.sharedInstance.isQuestionAnswered(questionID)
//            temp_question_Answered.append(isQuestionAnswered)
//        }
//        return temp_question_Answered
//    }
    
}


extension CampaignsViewController: CampaignViewContainerDelegate {
    func questionSelected(question: Question) {
        if let questionID = questionIDDictionary[question] {
            print(questionID)
            
            let AIDS = QIDToAIDSDictionary[questionID]!;
            let author = QIDToAuthorDictionary[questionID]!;
            ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author)
            
            let questionSegue = ModelInterface.sharedInstance.segueToQuestion()
            performSegueWithIdentifier(questionSegue, sender: self)
          
        }
    }
    func newQuestionSelected() {
        let newQuestionSegue = ModelInterface.sharedInstance.segueToCreateNewQuestion()
        performSegueWithIdentifier(newQuestionSegue, sender: self)
    }
  
    func resultsButtonSelected(question: Question ) {
    if let questionID = questionIDDictionary[question] {
        
        let AIDS = QIDToAIDSDictionary[questionID]!;
        let author = QIDToAuthorDictionary[questionID]!;
        ModelInterface.sharedInstance.setSelectedQuestion(AIDS, QID: questionID, questionText: question, author: author)
        let nextRoom = ModelInterface.sharedInstance.segueToResultsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
    }
    print("perform segue")
  }
  
}

