//
//  QuestionModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

protocol QuestionModelProtocol {
    
    //MARK: - Setting Question Information -
    func setNewQuestion(question: QuestionText) -> Question
    
    //MARK: - Getting Question Information -
    
    func processQuestionData(completionHandler: (listofAllQuestions: [Question]) -> ())
    func setSelectedQuestion(AIDS:[AnswerText], QID:QuestionID, questionText:QuestionText, author:Author, time: Double)
    func getSelectedQuestion() -> Question
    

    func getListOfQuestionsUserCreated() -> [QuestionID]
    func isQuestionAnswered(questionId: QuestionID) -> Bool
    
    //MARK: - Remove Question Information -
    func removeQuestion(questionId: QuestionID) -> Bool
    
    //MARK: - Helper Methods -
    func parseQIDNodeAndItsChildren(data: NSDictionary) -> [Question]
    func parseQuestionNodeInformation(data:NSDictionary, QID:QuestionID) -> Question
    func parseAIDs(data:NSDictionary) -> [AnswerID]

    
    //MARK: - Segues -
    func segueToQuestionsUserCreated() -> SegueName
    func segueToQuestionsNearMe() -> SegueName
    func segueToQuestion() -> SegueName
    func segueToCreateNewQuestion() -> SegueName
    func segueToQuestionsScreen() -> SegueName
    func segueToAdminScreen() -> SegueName
    func segueToResultsScreen() -> SegueName
    func segueTotoPollAdminVCFromCampaign() -> SegueName
}
