//
//  CampaignViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CampaignViewContainerDelegate {
    func questionSelected(question: QuestionText)
    func newQuestionSelected()
    func resultsButtonSelected(question:QuestionText)
    func refreshQuestions()
}

class CampaignViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var roomName: UILabel!
    
    @IBAction func refresh(sender: AnyObject) {
          delegate?.refreshQuestions()
    }
    private var questions:[QuestionText] = []
    private var questionsAnswered:[Bool] = []
    private var authors:[Author] = []
    private var expiry:[String] = []
    private var isExpired:[Bool] = []
    
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
    
    func setRoomNameTitle(name: String) {
        roomName.text = name;
    }
    
    func setQuestions(questionNames: [QuestionText]) {
        questions = questionNames
    }
    
    func setQuestionAnswered(questions: [Bool]) {
        questionsAnswered = questions
    }
    
    func setAuthors (authors:[Author]) {
        self.authors = authors;
    }
    func setExpiryMessages(expiry: [String]) {
        self.expiry = expiry
    }
    func setIsExpired(expired: [Bool]) {
        isExpired = expired
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let nib_name = UINib(nibName: "CampaignViewTableViewCell", bundle: nil)
        tableView.registerNib(nib_name, forCellReuseIdentifier: "campaignCell")
        let cell = self.tableView.dequeueReusableCellWithIdentifier("campaignCell", forIndexPath: indexPath) as! CampaignViewTableViewCell
        cell.delegate = self
        cell.setQuestionText(questions[indexPath.row])
        cell.setAnsweredBackground(questionsAnswered[indexPath.row])
        if (authors[indexPath.row] == currentUser) {
            cell.setAuthorText("Yours")
        } else {
            cell.setAuthorText(authors[indexPath.row])
        }
        cell.setExpiryMessage(expiry[indexPath.row])
        cell.setIsExpired(isExpired[indexPath.row])
        if(!questionsAnswered[indexPath.row]){
            cell.hideResultsLabel()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
}

extension CampaignViewContainer: CampaignViewTableViewCellDelegate {
    func resultsButtonSelected(question:String) {
        delegate?.resultsButtonSelected(question)
    }
    
    func questionSelected(question: String) {
        print(question)
        delegate?.questionSelected(question)
        
    }

}
