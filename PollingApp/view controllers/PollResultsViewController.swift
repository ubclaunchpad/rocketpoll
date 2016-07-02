//
//  PollResultsViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
import Firebase

class PollResultsViewController: UIViewController {
    
    private var answerIDDictionary = [AnswerText: AnswerID]()
    private var questionID:QuestionID = ""
    private var answers: [AnswerText] = []
    private var answerIDs: [AnswerID] = []
    private var correctAnswer: AnswerText = ""
    private var correctAnswerId: AnswerID = ""
    private var NumResponsesPerAnswer: [Int] = []
    var totalNumberOfUserAnswers: Int = 0
    
    var container: PollResultsViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContainerToVC()
    }
    
    func addContainerToVC() {
        container = PollResultsViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)

        //TODO:IPA-125
        questionID = ModelInterface.sharedInstance.getSelectedQuestion().QID
        let questionText = ModelInterface.sharedInstance.getSelectedQuestion().questionText
        answerIDs = ModelInterface.sharedInstance.getSelectedQuestion().AIDS
        
        ModelInterface.sharedInstance.processAnswerData(answerIDs) { (listofAllAnswers) in
            self.fillInTheFields(listofAllAnswers)
            self.container?.delegate = self
            self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
            self.container?.setQuestionLabelText(questionText)
            self.container?.setAnswers(self.answers)
            self.container?.setCorrectAnswer(self.correctAnswer)
            self.container?.setNumberOfResponsesForAnswer(self.NumResponsesPerAnswer)
            self.container?.resultsTableView.reloadData()
            self.container?.setTotalNumberOfAnswers(self.totalNumberOfUserAnswers)
        }
    }
    
    func fillInTheFields (listofAllAnswers: [Answer]) {
        let size = listofAllAnswers.count
        for i in 0 ..< size  {
            let tempAnswer = listofAllAnswers[i].answerText
            self.answerIDDictionary[tempAnswer] = self.answerIDs[i]
            self.answers.append(tempAnswer)
            if (listofAllAnswers[i].isCorrect == true ) {
                self.correctAnswer = listofAllAnswers[i].answerText
            }
            self.totalNumberOfUserAnswers += listofAllAnswers[i].tally
            
            self.NumResponsesPerAnswer.append(listofAllAnswers[i].tally)
        }
    }
}

extension PollResultsViewController: PollResultsViewContainerDelegate {
    func goBackToCampaign() {
        let nextRoom = ModelInterface.sharedInstance.segueToQuestionsScreen()
        performSegueWithIdentifier(nextRoom, sender: self)
    }
    
}

