//
//  ModelInterface.swift
//  PollingApp
//
//  Created by Jon on 2016-03-03.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class ModelInterface {
  
  //MARK: - Name -
  func setUserName(name : String) -> String {
    return Segues.toMainApp
  }
  
  //MARK: - Room -
  func setRoomName(name : String) -> String {
    return Segues.toMainApp
  }
  func getQuestionsICreatedScreenName() -> String {
    return Segues.toMainApp
  }
  func getQuestionsNearMeScreenName() -> String {
    return Segues.toMainApp
  }
  
  //MARK: - RoomsNeaby -
  func getRoomsNearby() -> [String] {
    return ["R1"] //roomIDs
  }
  func getRoomName(roomID : String) -> String {
    return "RoomName"
  }
  func goToRoom(roomID : String) -> String {
    return Segues.toMainApp
  }
  
  //MARK: - CreatedQuestions -
  func getQuestionsUserCreated() -> [String] {
    return ["Q1"] //questionIDs
  }
  func getQuestionName(questionID : String) -> Bool {
    return true
  }
  func goToQuestion(questionId : String) -> String {
    return Segues.toMainApp
  }
  
  //MARK: - Questions	-
  func getRoomName() -> String {
    return "RoomName"
  }
  func getListOfQuestionIDs() -> [String] {
    return ["Q1"]
  }
  func getQuestion(question : String) -> String {
    return "Question"
  }
  func isQuestionAnswered(questionID : String) -> Bool {
    return true
  }
  //Duplicate
//  func goToQuestion(questionId : String) -> String {
//    return Segues.toMainApp
//  }
  func createQuestion() -> String {
    return Segues.toMainApp
  }
  
  //MARK: - NewQuestion -
  func setQuestion(question : String) -> Bool {
    return true
  }
  func setAnswers() -> Bool {
    return true
  }
  //TODO: find out how send a list of tupples or do this another way
  //  func setAnswers([(String answers, Bool correctAnswer]) listOfTupleAnswers) -> Bool {
  //    return true
  //  }
  
  //Duplicate
//  func createQuestion() -> String {
//    return Segues.toMainApp
//  }
  func setTimerSeconds(seconds : Int) -> Bool {
    return true
  }
  
  //MARK: - PollUser -
  func getCountdownSeconds() -> Int {
    return 42
  }
  func getQuestion() -> String {
    return "question"
  }
  func getListOfAnswerIDs() -> [String] {
    return ["A1"] //answerIDs
  }
  func getAnswer(answerID : String) -> String {
    return "Answer"
  }
  func setUserAnswer(questionID : String, answerID : String) -> Bool {
    return true
  }
  
  //MARK: - PollUserResult -
  
  //Duplicate
//  func getQuestion() -> String {
//    return "Question"
//  }
  
  //Duplicate
//  func getListOfAnswerIDs() -> [String] {
//    return [1,2,3] //answerIDs
//  }
  //Duplicate
//  func getAnswer(String answerID) -> String {
//    return "Answer"
//  }
  func getCorrectAnswer() -> String {
    return "AnswerId" //answerID
  }
  
  //MARK: - Admin -
  func getQuestionID() -> String {
    return "QuestionId"
  }
  //Duplicate
//  func getQuestion() -> String {
//    return "Question"
//  }
  //Duplicate
//  func getCountdownSeconds() -> Int {
//    return 42
//  }
  //Duplicate
//  func getListOfAnswerIDs() -> [String]{
//    return ["A1","A2","A3"] //answerIDs
//  }
  //Duplicate
//  func getAnswer(answerID : String) -> String {
//    return "Answer"
//  }
  //Duplicate
//  func getCorrectAnswer() -> String {
//    return "A1"
//  }
  func getTotalAnswers() -> Int {
    return 4
  }
  func getNumberOfAnswers(answerID : String) -> Int {
    return 2
  }
  func stopTimer(questionID : String) -> Bool {
    return true
  }
  func removeQuestion(questionID : String) -> Bool {
    return true
  }
  
}
