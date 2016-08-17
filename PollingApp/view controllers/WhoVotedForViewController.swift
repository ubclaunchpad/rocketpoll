//
//  WhoVotedForViewController.swift
//  PollingApp
//
//  Created by James Park on 2016-08-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
import Firebase
import Foundation


class WhoVotedForViewController: UIViewController {
  
  private var container: WhoVotedForContainer?
  private var listOfUsers = [Author]()
  var selectedAnswer:Answer?
  var questionText:QuestionText?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerToVC()
    Log.debug("loaded WhoVotedForCampaignViewController")
    
  }
  
  func addContainerToVC() {
    let answerText = selectedAnswer?.answerText
    let AID = selectedAnswer?.AID
    
    container = WhoVotedForContainer.instanceFromNib(
      CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(self.container!)
    
    ModelInterface.sharedInstance.getListOfUsersWhoVoteForGivenAnswer(AID!) { (listOfUsers) in
      self.listOfUsers = listOfUsers
      self.container?.delegate = self
      self.container?.setListUsers(listOfUsers)
      self.container?.setTextForAnswerLabel(answerText!)
      self.container?.setTextForQuestionLabel(self.questionText!)
      self.container?.TableOfUsers.reloadData()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}
extension WhoVotedForViewController: WhoVotedForViewContainerDelegate {
  
  
}
