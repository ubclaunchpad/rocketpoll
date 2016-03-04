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
  func setUserName(String name) -> Segues {
    return Segues.toMainApp
  }
  
  //MARK: - Room -
  func setRoomName(String name) -> Segues {
    return Segues.toMainApp
  }
  func getQuestionsICreatedScreenName() -> Segues {
    return Segues.toMainApp
  }
  func getQuestionsNearMeScreenName() -> Segues {
    
  }
  
  //MARK: - RoomsNeaby -
  func getRoomsNearby() -> [String] {
    return [1,2,3] //roomIDs
  }
  func getRoomName(String roomID) -> String {
    return "RoomName"
  }
  func goToRoom(String roomID) -> Segues {
    return Segues.toMainApp
  }
  
  //MARK: - CreatedQuestions -
  func getQuestionsUserCreated() -> [String] {
    return [1,2,3] //questionIDs
  }
  func getQuestionName(String questionID) -> Bool {
    return true
  }
  func goToQuestion(String questionId) -> Segues {
    return Segues.toMainApp
  }
  
  //MARK: - Questions	-
  func getRoomName() -> String {
    return "RoomName"
  }
  func getListOfQuestionIDs() -> [String] {
    return [1,2,3] //questionIDs
  }
  func getQuestion(Sting question) -> String {
    return "Question"
  }
  func isQuestionAnswered(String questionID) -> Bool {
    return true
  }
  func goToQuestion(String questionId) -> Segues {
    return Segues.toMainApp
  }
  func createQuestion() -> Segues {
    return Segues.toMainApp
  }
  
  //MARK: - NewQuestion -
  func setQuestion(String question) -> Bool {
    return true
  }
  func setAnswers() -> Bool {
    return true
  }
  //TODO: find out how send a list of tupples or do this another way
//  func setAnswers([(String answers, Bool correctAnswer]) listOfTupleAnswers) -> Bool {
//    return true
//  }
  func createQuestion() -> Segues {
    return Segues.toMainApp
  }
  func setTimerSeconds(Int seconds) -> Bool {
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
    return [1,2,3] //answerIDs
  }
  func getAnswer(String answerID) -> String {
    return "Answer"
  }
  func setUserAnswer(String questionID, String answerID) -> Bool {
    return true
  }
  
  //MARK: - PollUserResult -
  func getQuestion() -> String {
    return "Question"
  }
  func getListOfAnswerIDs() -> [String] {
    return [1,2,3] //answerIDs
  }
  func getAnswer(String answerID) -> String {
    return "Answer"
  }
  func getCorrectAnswer() -> Sting {
    return "AnswerId" //answerID
  }
  
  //MARK: - Admin -
  func getQuestionID() -> String {
    return "QuestionId"
  }
  func getQuestion() -> String {
    return "Question"
  }
  func getCountdownSeconds() -> Int {
    return 42
  }
  func getListOfAnswerIDs() -> [String]{
    return ["A1","A2","A3"] //answerIDs
  }
  func getAnswer(String answerID) -> String {
    return "Answer"
  }
  func getCorrectAnswer() -> String {
    return "A1"
  }
  func getTotalAnswers() -> Int {
    return 4
  }
  func getNumberOfAnswers(String answerID) -> Int {
    return 2
  }
  func stopTimer(String questionID) -> Bool {
    return true
  }
  func removeQuestion(String questionID) -> Segues {
    return Segues.toMainApp
  }
  
}
