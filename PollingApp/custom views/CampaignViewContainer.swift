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
  @IBOutlet weak var emptyLabel: UILabel!
  
  @IBAction func refresh(sender: AnyObject) {
    delegate?.refreshQuestions()
  }
  
  var delegate: CampaignViewContainerDelegate?
  
  @IBAction func newQuestionPressed(sender: AnyObject) {
    delegate?.newQuestionSelected()
  }
  
  class func instancefromNib(frame: CGRect) -> CampaignViewContainer {
    let view = UINib(nibName: "CampaignViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CampaignViewContainer
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    view.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    view.tableView.backgroundColor = UIColor.clearColor()
    view.tableView.opaque = false
    return view
  }
  
  func setTableCells(questions: [Question]) {
    self.questionCells = questions
    if questions.isEmpty {
      emptyLabel.hidden = false
    } else {
      emptyLabel.hidden = true
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questionCells.count
  }
  
  var questionCells = [Question]()
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let nib_name = UINib(nibName: "CampaignViewTableViewCell", bundle: nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "campaignCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("campaignCell", forIndexPath: indexPath) as! CampaignViewTableViewCell
    cell.delegate = self

    
    cell.setQuestionText( questionCells[indexPath.row].questionText)
    
    cell.setAuthorText( questionCells[indexPath.row].author)
    
    cell.setExpiryMessage( questionCells[indexPath.row].expireMessage)
    cell.setFieldQuestion(questionCells[indexPath.row])
    
    cell.backgroundColor = UIColor.clearColor()
    cell.backgroundImage.image = UIImage(named: "QuestionCell")!
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    let sections = [yourQuestions, answeredQuestions, unansweredQuestions, expiredQuestions]
    guard let question = questionCells[indexPath.row] as? Question else {
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

}

extension CampaignViewContainer: CampaignViewTableViewCellDelegate {
  
  func questionSelected(question: Question) {
    delegate?.questionSelected(question)
  }
  
}
