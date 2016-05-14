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
    func resultsButtonSelected()
}

class CampaignViewTableViewCell: UITableViewCell {
    
    var delegate: CampaignViewTableViewCellDelegate?

    @IBOutlet weak var button: UIButton!
  @IBOutlet weak var resultsButton: UIButton!

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
      delegate?.resultsButtonSelected()
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

}
