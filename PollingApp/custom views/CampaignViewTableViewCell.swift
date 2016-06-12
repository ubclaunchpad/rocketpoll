//
//  CampaignView.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CampaignViewTableViewCellDelegate {
    func questionSelected(question: Question)
    func resultsButtonSelected(question: Question)
}

class CampaignViewTableViewCell: UITableViewCell {
    
    var delegate: CampaignViewTableViewCellDelegate?
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    @IBOutlet weak var author: UILabel!
    @IBAction func buttonPressed(sender: AnyObject) {
        if let senderTitle = sender.currentTitle {
            delegate?.questionSelected(senderTitle!)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func resultsButtonPressed(sender: AnyObject) {
        delegate?.resultsButtonSelected(button.titleLabel!.text!)
    }
    
    func hideResultsLabel(){
        resultsButton.alpha = 0;
    }
    
    func setQuestionText(questionName: Question) {
        button.setTitle(questionName, forState: UIControlState.Normal)
    }
    
    func setAnsweredBackground(isAnswered: Bool) {
        if isAnswered {
            self.backgroundColor = UIColor.lightGrayColor()
        }
    }
    
    func setAuthorText(author: String) {
        self.author.text = author;
    }
    
}
