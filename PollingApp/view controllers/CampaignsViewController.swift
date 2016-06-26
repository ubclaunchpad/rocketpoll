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
    private var expiry = [String]()
    private var isExpired = [Bool]()
    
    
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
        ModelInterface.sharedInstance.processQuestionData { (listofAllQuestions, listOfQuestionID) in
            
            self.fillInTheFields(listofAllQuestions,listOfQuestionID: listOfQuestionID)
            let roomID = ModelInterface.sharedInstance.getCurrentRoomID()
            let roomName = ModelInterface.sharedInstance.getRoomName(roomID)
            
            self.container?.setAuthors(self.authors)
            self.container?.setRoomNameTitle(roomName)
            
            self.container?.delegate = self
            self.container?.setQuestions(self.questions)
            self.container?.setQuestionAnswered(self.questionsAnswered)
            //            self.container?.tableView.reloadData()
        }
    }
    
    
    func fillInTheFields (listofAllQuestions:[Question], listOfQuestionID:[QuestionID]) {
        let size = listofAllQuestions.count
        for i in 0 ..< size  {
            self.questions.append(listofAllQuestions[i].questionText)
            self.authors.append(listofAllQuestions[i].author)
            self.questionsAnswered.append(true)
            self.questionIDDictionary[listofAllQuestions[i].questionText] = listofAllQuestions[i].QID
            self.QIDToAIDSDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].AIDS
            self.QIDToAuthorDictionary[listofAllQuestions[i].QID] = listofAllQuestions[i].author
            ModelInterface.sharedInstance.getCountdownSeconds(listOfQuestionID[i], completion: { (time) -> Void in
                if time > 0 {
                    let currentTime = Int(NSDate().timeIntervalSince1970)
                    let difference = currentTime - Int(time)
                    let absDifference = abs(difference)
                    
                    if absDifference < 300 {
                        if difference > 0 {
                            self.isExpired.append(true)
                            self.expiry.append("Poll ended a couple moments ago")
                        } else {
                            self.isExpired.append(false)
                            self.expiry.append("Poll ends in a couple moments")
                        }
                    }
                    else if absDifference < 3600 {
                        let minutes = Int(absDifference/60)
                        if difference > 0 {
                            self.isExpired.append(true)
                            self.expiry.append("Poll ended \(minutes) minutes ago")
                        } else {
                            self.isExpired.append(false)
                            self.expiry.append("Poll ends in \(minutes) minutes")
                        }
                    }
                    else if absDifference < 86400 {
                        let hours = Int(absDifference/3600)
                        if difference > 0 {
                            self.isExpired.append(true)
                            if hours > 1 {
                                self.expiry.append("Poll ended \(hours) hours ago")
                            } else {
                                self.expiry.append("Poll ended \(hours) hour ago")
                            }
                        } else {
                            self.isExpired.append(false)
                            if hours > 1 {
                                self.expiry.append("Poll ends in \(hours) hours")
                            } else {
                                self.expiry.append("Poll ends in \(hours) hour")
                            }
                        }
                    }
                    else {
                        let days = Int(absDifference/86400)
                        if difference > 0 {
                            self.isExpired.append(true)
                            if days > 1 {
                                self.expiry.append("Poll ended \(days) days ago")
                            } else {
                                self.expiry.append("Poll ended \(days) day ago")
                            }
                        } else {
                            self.isExpired.append(false)
                            if days > 1 {
                                self.expiry.append("Poll ends in \(days) days")
                            } else {
                                self.expiry.append("Poll ends in \(days) day")
                            }
                        }
                        
                    }
                    
                }
                if i == size - 1 {
                    self.container?.setExpiryMessages(self.expiry)
                    self.container?.setIsExpired(self.isExpired)
                    
                    self.container?.tableView.reloadData()
                }
            })
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

