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
  
  private var answerIDDictionary = [Answer: AnswerID]()
  private var questionID:QuestionID = ""
  var container: PollResultsViewContainer?
  private var answers: [Answer] = []
  private var answerIDs: [AnswerID] = []
  private var correctAnswer: Answer = ""
  private var correctAnswerId: AnswerID = ""
  private var NumResponsesPerAnswer: [Int] = []
  var totalNumberOfUserAnswers: Int = 0
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    
    questionID = ModelInterface.sharedInstance.getQuestionID()
    let questionText: Question = ModelInterface.sharedInstance.getQuestion(questionID)
    answerIDs = ModelInterface.sharedInstance.getListOfAnswerIDs(questionID)
    correctAnswerId = ModelInterface.sharedInstance.getCorrectAnswer(questionID)
    correctAnswer = ModelInterface.sharedInstance.getAnswer(correctAnswerId)
    answers = getAnswers(answerIDs)
    totalNumberOfUserAnswers = ModelInterface.sharedInstance.getSumOfUsersThatSubmittedAnswers(questionID)
    // NumResponsesPerAnswer = ModelInterface.sharedInstance.
    NumResponsesPerAnswer = [5,10,15,0] //TODO: delete this line
    
    container = PollResultsViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
    
    container?.setTotalNumberOfAnswers(totalNumberOfUserAnswers)
    container?.setQuestionLabelText(questionText)
    container?.setAnswers(answers)
    container?.setCorrectAnswer(correctAnswer)
    container?.setNumberOfResponsesForAnswer(NumResponsesPerAnswer)
    
  }
  
  func getAnswers(answerIDs: [AnswerID]) -> [Answer] {
    // Changes the list of answerIDs to list of answers
    var answers = [String]()
    var temp_answer:Answer
    
    for answerID in answerIDs {
      temp_answer = ModelInterface.sharedInstance.getAnswer(answerID)
      answers.append(temp_answer)
      answerIDDictionary[temp_answer] = answerID
    }
    return answers
  }
}

