//
//  AnswerViewTableViewCell.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-03-15.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol AnswerViewTableViewCellDelegate{
    func answerSelected(answer: Answer)
}

class AnswerViewTableViewCell: UITableViewCell {
  @IBOutlet var answerButton: UIButton!
    var delegate: AnswerViewTableViewCellDelegate?
    
    @IBAction func cellAnswerButtonPressed(sender: AnyObject) {
        if let selectedAnswer = sender.currentTitle {
            print(selectedAnswer)
            delegate?.answerSelected(selectedAnswer!);
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setAnswerText(answer: String) {
         answerButton.setTitle("testing", forState: UIControlState.Normal)
        //answerButton.setTitle(answer, forState:UIControlState.Normal )
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
