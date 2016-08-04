//
//  CampaignView.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CampaignViewTableViewCellDelegate {
  func resultsButtonSelected(question: Question)
}

class CampaignViewTableViewCell: UITableViewCell {
  
  var delegate: CampaignViewTableViewCellDelegate?
  
  @IBOutlet weak var author: UILabel!
  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var resultsButton: UIButton!
  @IBOutlet weak var expiry: UILabel!
  
  private var isExpired:Bool?
  private var question:Question?
  
  @IBAction func buttonPressed(sender: AnyObject) {
    if isExpired == false {
      if let senderTitle = sender.currentTitle {
        //delegate?.questionSelected(senderTitle!)
      }
    } else {
      delegate?.resultsButtonSelected(question!)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  @IBAction func resultsButtonPressed(sender: AnyObject) {
    delegate?.resultsButtonSelected(question!)
  }
  
  func hideResultsLabel(expired: Bool){
    if (expired) {
      resultsButton.alpha = 1;
    } else {
      resultsButton.alpha = 0;
    }
  }
  
  func setFieldQuestion (question: Question) {
    self.question = question
  }

  func setQuestionText(questionName: QuestionText) {
    button.setTitle(questionName, forState: UIControlState.Normal)
  }
  
  func setAuthorText(author:Author) {
    self.author.text = author;
  }
  func setExpiryMessage(expiry: String) {
    self.expiry.text = expiry
  }
  func setIsExpired(expired: Bool) {
    isExpired = expired
  }
  
  func setAnsweredBackground(isAnswered: Bool) {
    if isAnswered {
      self.backgroundColor = UIColor.lightGrayColor()
    } else {
        self.backgroundColor = UIColor.clearColor()
    }
  }
  
}
