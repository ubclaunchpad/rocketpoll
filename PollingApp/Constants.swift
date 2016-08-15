//
//  Constants.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import UIKit

typealias QuestionID = String
typealias QuestionText = String
typealias AnswerID = String
typealias AnswerText = String
typealias Author = String
typealias SegueName = String
typealias RoomID = String

var currentUser:Author = "" //TODO: this should persist on phone restart
var currentID  = ""
var okayNameCharacters : Set<Character> =
  Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)


var launchpadEmail: String = "@ubclaunchpad.com"
var numberOfAnswers: String = "Number of users that answered: %1%"
var tallyString: String = "%1% total votes"

var charactersToAvoid : [Character] =
  Array("#[]*".characters)

let setTimerValues:[Int] = [1, -1, 5, -5, 15, -15, 60, -60]

let calendar = NSCalendar.currentCalendar()

enum colors {
  static let green = UIColor(red: 28/255.0, green: 165/255.0, blue: 122/255.0, alpha: 1)
  static let lightGreen = UIColor(red: 226/255.0, green: 250/255.0, blue: 218/255.0, alpha: 1)
  static let barGraphColour = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
  static let textColor = UIColor(red: 98/255.0, green: 98/255.0, blue: 98/255.0, alpha: 1)
  static let backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
}

enum Segues {
  static let toMainApp = "showMainApp"
  static let toQuestionsScreen = "toQuestionsScreen"
  static let toPollUserViewController = "toPollUserViewController"
  static let toCreateQuestionView = "toCreateQuestionView"
  static let toPollAdminScreen = "toPollAdminScreen"
  static let toPollResultsView = "toPollResultsView"
  static let toPollAdminVCFromCampaign = "toPollAdminVCFromCampaign"
  static let toWhoVotedForVCFromAdmin = "toWhoVotedForVCFromAdmin"
  static let toWhoVotedForVCFromPollResult = "toWhoVotedForVCFromPollResult"
}

enum UIStringConstants {
  static let lessThanOneDayLeft = "Less than one day"
  static let notCorrect = "notCorrect"
}

enum UITimeConstants {
  static let oneDayinSeconds = 86400
  static let oneHourinSeconds = 3600
  static let oneMinuteinSeconds = 60
  static let oneHourinMinutes = 60
  static let oneDayinMinutes = 1440
  static let moment = 300
}

enum UIDaysRemaining {
  static let singularDay = "Day Left"
  static let pluralDay = "Days Left"
}

enum UITimeRemaining {
  static let endedMoments = "Ended a couple moments ago"
  static let endsMoments = "Ends in a couple moments"
  static let endedMinutes = "Ended %1% minutes ago"
  static let endsMinutes = "%1% minutes"
  static let endedHour = "Ended %1% hour ago"
  static let endsHour = "%1% hour"
  static let endedHours = "Ended %1% hours ago"
  static let endsHours = "%1% hours"
  static let endsDays = "%1% days"
  static let endsDay = "%1% day"
  static let timerMinutes = "Minutes: %1%"
  static let timerMinute = "Minute: %1%"
  static let timerHours = "Hours: %1%"
  static let timerHour = "Hour: %1%"
  static let timerTextDayHourMinute = "Question will end in %1% day, %2% hour and %3% minute, at %4%"
  static let timerTextDayHoursMinutes = "Question will end in %1% day, %2% hours and %3% minutes, at %4%"
  static let timerTextDayHoursMinute = "Question will end in %1% day, %2% hours and %3% minute, at %4%"
  static let timerTextDayHourMinutes = "Question will end in %1% day, %2% hour and %3% minutes, at %4%"
  
  static let timerTextDaysHourMinute = "Question will end in %1% days, %2% hour and %3% minute, at %4%"
  static let timerTextDaysHoursMinutes = "Question will end in %1% days, %2% hours and %3% minutes, at %4%"
  static let timerTextDaysHoursMinute = "Question will end in %1% days, %2% hours and %3% minute, at %4%"
  static let timerTextDaysHourMinutes = "Question will end in %1% days, %2% hour and %3% minutes, at %4%"
  
  static let timerTextHourMinute = "Question will end in %1% hour and %2% minute, at %3%"
  static let timerTextHoursMinute = "Question will end in %1% hours and %2% minute, at %3%"
  static let timerTextHourMinutes = "Question will end in %1% hour and %2% minutes, at %3%"
  static let timerTextHoursMinutes = "Question will end in %1% hours and %2% minutes, at %3%"
  static let timerTextMinutes = "Question will end in %1% minutes, at %2%"
  static let timerTextMinute = "Question will end in %1% minute, at %2%"
}

enum alertMessages {
  static let invalid = "Invalid Name"
  static let empty = "Please enter your name"
  static let emptyQuestions = "Please enter a question"
  static let confirm = "OK"
  static let yes = "YES"
  static let no = "NO"
  static let confirmName = "Pleaes confirm that your name is "
  static let nameMessage = "You will not be able to change your name at a later time"
  static let confirmation = "Confirmation"
  static let confirmationMessage = "Are you sure you want to delete your quesiton?"
  static let duplicateAnswer = "One or more of the answers are the same"
  static let emptyAnswer = "Please fill in all answer fields"
  static let noCorrectAnswer = "Please select a correct answer"
  static let noRevoting = "You have already selected this answer. Choose a different answer"
  static let usernameIsTaken = "Please choose another name. This name is already taken."
  static let symbolAnswer = "One of more of the answers contain a symbol"
  static let symbolQuestion = "The question you have submitted contains a symbol"
}

enum correct {
  static let isCorrect = "Correct"
  static let notCorrect = "not Correct"
}

enum imageNames {
  static let setIncorrect = "SetIncorrect"
  static let setCorrect = "SetCorrect"
}

enum cellDimensions {
  static let pollAdminCellHeight:CGFloat = 58
}

enum navigationBarAttributes {
  static let textColor = UIColor(red: 82/255.0, green: 82/255.0, blue: 82/255.0, alpha: 1)
  static let backgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
  static let titleFont = UIFont(name: "Roboto-Medium", size: 14)
  static let buttonFont = UIFont(name: "Roboto-Medium", size: 15)
}

/**
 A log level of debug will print out all levels above it.
 So a log level of WARN will print out WARN, ERROR, and TEST
 */
enum LogLevel {
  static let lvl = LogLevelChoices.DEBUG
}

enum LogLevelChoices {
  static let DEBUG = 1
  static let INFO = 2
  static let WARN = 3
  static let ERROR = 4
  static let TEST = 5
}

enum CampaginSection {
  static let sectionNames =
        ["Questions You Created",
         "Questions You Answered",
         "Unanswered Questions",
         "Expired Questions"]
  
  static let yourQuestionsSectionIndex = 0 
  static let answeredQuestionsSectionIndex = 1
  static let unansweredQuestionsSectionIndex = 2
  static let expiredQuestionsSectionIndex = 3
  
  
}


