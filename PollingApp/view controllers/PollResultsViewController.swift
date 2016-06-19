//
//  PollResultsViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollResultsViewController: UIViewController {
    
    private var answerIDDictionary = [String: AnswerID]()
    private var questionID:QuestionID = ""
    var container: PollResultsViewContainer?
    private var answers: [String] = []
    private var answerIDs: [AnswerID] = []
    private var correctAnswer: String = ""
    private var correctAnswerId: AnswerID = ""
    private var NumResponsesPerAnswer: [Int] = []
    var totalNumberOfUserAnswers: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        container = PollResultsViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        questionID = ModelInterface.sharedInstance.getSelectedQuestion().QID
        let questionText: String = ModelInterface.sharedInstance.getSelectedQuestion().questionText
        answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
        
        ModelInterface.sharedInstance.processAnswerData(answerIDs) { (listofAllAnswers) in
            let size = listofAllAnswers.count
            for i in 0 ..< size  {
                let tempAnswer = listofAllAnswers[i].getAnswerText()
                self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
                self.answers.append(tempAnswer)
                if (listofAllAnswers[i].getIsCorrect() == true ) {
                    self.correctAnswer = listofAllAnswers[i].getAnswerText()
                }
            }
            self.totalNumberOfUserAnswers = ModelInterface.sharedInstance.getSumOfUsersThatSubmittedAnswers(self.questionID)
            
            for i in 0...self.answerIDs.count-1{
                self.NumResponsesPerAnswer.append(ModelInterface.sharedInstance.getNumberOfUsersThatGaveThisAnswer(self.questionID,answerID: self.answerIDs[i]))
            }
            
            self.container?.delegate = self
            self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
            self.container?.setQuestionLabelText(questionText)
            self.container?.setAnswers(self.answers)
            self.container?.setCorrectAnswer(self.correctAnswer)
            self.container?.setNumberOfResponsesForAnswer(self.NumResponsesPerAnswer)
            self.container?.resultsTableView.reloadData()
        }
        
        
        
        
    }
    
//    func getAnswers(answerIDs: [AnswerID]) -> [Answer] {
//        // Changes the list of answerIDs to list of answers
//        var answers = [String]()
//        var temp_answer:Answer
//        
//        for answerID in answerIDs {
//            temp_answer = ModelInterface.sharedInstance.getAnswer(answerID)
//            answers.append(temp_answer)
//            answerIDDictionary[temp_answer] = answerID
//        }
//        return answers
//    }
}


extension PollResultsViewController: PollResultsViewContainerDelegate {
    func goBackToCampaign() {
        let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
    }
    
}

