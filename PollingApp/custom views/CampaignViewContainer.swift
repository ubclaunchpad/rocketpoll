//
//  CampaignViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CampaignViewContainerDelegate {
  func questionSelected(question: Question)
  func newQuestionSelected()
  func resultsButtonSelected(question: Question)
  func refreshQuestions()
}

class CampaignViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var roomName: UILabel!
  
  @IBAction func refresh(sender: AnyObject) {
    delegate?.refreshQuestions()
  }
  private var unansweredQuestions:[Question] = []
  private var expiredQuestions:[Question] = []
  private var yourQuestions:[Question] = []
  private var answeredQuestions:[Question] = []
  
  var delegate: CampaignViewContainerDelegate?
  
  @IBAction func newQuestionPressed(sender: AnyObject) {
    delegate?.newQuestionSelected()
  }
  
  class func instancefromNib(frame: CGRect) -> CampaignViewContainer {
    let view = UINib(nibName: "CampaignViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CampaignViewContainer
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    return view
  }
  
//  func setRoomNameTitle(name: String) {
//    roomName.text = name;
//  }
  
  func setUnansweredQuestions(unansweredQuestions: [Question]) {
    self.unansweredQuestions = unansweredQuestions
  }
  
  func setExpiredQuestions (expiredQuestions: [Question]) {
    self.expiredQuestions = expiredQuestions
  }
  func setYourQuestions(yourQuestions: [Question]) {
    self.yourQuestions = yourQuestions
  }
  
  func setAnsweredQuestion(answeredQuestions : [Question]) {
    self.answeredQuestions = answeredQuestions
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return yourQuestions.count
    case 1:
      return answeredQuestions.count
    case 2:
      return unansweredQuestions.count
    case 3:
      return expiredQuestions.count
    default:
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let nib_name = UINib(nibName: "CampaignViewTableViewCell", bundle: nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "campaignCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("campaignCell", forIndexPath: indexPath) as! CampaignViewTableViewCell
    cell.delegate = self
    
    var templistQuestions = [Question]()
    
    switch indexPath.section {
      case 0:
        templistQuestions = yourQuestions
      case 1:
        templistQuestions = answeredQuestions
      case 2:
        templistQuestions = unansweredQuestions
      case 3:
        templistQuestions = expiredQuestions
      default:
        break
    }
    
    cell.setQuestionText( templistQuestions[indexPath.row].questionText)
    cell.setAnsweredBackground(templistQuestions[indexPath.row].isExpired)
    
    cell.setAuthorText( templistQuestions[indexPath.row].author)
    
    cell.setExpiryMessage( templistQuestions[indexPath.row].expireMessage)
    cell.setFieldQuestion(templistQuestions[indexPath.row])
    
    cell.hideResultsLabel(templistQuestions[indexPath.row].isExpired)
  
    cell.backgroundColor = UIColor.clearColor()
    cell.backgroundImage.image = UIImage(named: "QuestionCell")!
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let sections = [yourQuestions, answeredQuestions, unansweredQuestions, expiredQuestions]
    guard let question = sections[indexPath.section][indexPath.row] as? Question else {
      return
    }
    if question.isExpired == false {
        delegate?.questionSelected(question)
    } else {
      delegate?.resultsButtonSelected(question)
    }
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 84
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   return CampaginSection.sectionNames[section]
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return  CampaginSection.sectionNames.count
  }
}

extension CampaignViewContainer: CampaignViewTableViewCellDelegate {
  func resultsButtonSelected(question: Question) {
    delegate?.resultsButtonSelected(question)
  }
  func questionSelected(question: Question) {
    delegate?.questionSelected(question)
  }
  
}
