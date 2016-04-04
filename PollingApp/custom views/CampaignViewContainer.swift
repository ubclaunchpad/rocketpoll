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
}

class CampaignViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var roomName: UILabel!
    
    private var questions:[Question] = []
    private var questionsAnswered:[Bool] = []
    
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
    
    func setQuestions(questionNames: [Question]) {
        questions = questionNames
    }
    
    func setQuestionAnswered(questions: [Bool]) {
        questionsAnswered = questions
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
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
}
extension CampaignViewContainer: CampaignViewTableViewCellDelegate {
    func questionSelected(question: Question) {
        print(question)
        delegate?.questionSelected(question)
    }
}
