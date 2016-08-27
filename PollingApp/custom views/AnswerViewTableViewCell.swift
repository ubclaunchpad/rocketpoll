//
//  AnswerViewTableViewCell.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-03-15.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol AnswerViewTableViewCellDelegate{
}

class AnswerViewTableViewCell: UITableViewCell {
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var answer: UILabel!
  var delegate: AnswerViewTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setAnswerText(setAnswer: String) {
    answer.text = setAnswer
    answer.numberOfLines = 0
    answer.lineBreakMode = NSLineBreakMode.ByTruncatingTail
    answer.sizeToFit()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    if !selected {
      backgroundImage.image = UIImage(named: "AnswerCell")!
      answer.textColor = colors.textColor
    } else {
      backgroundImage.image = UIImage(named: "AnswerCellSelected")!
      answer.textColor = UIColor.whiteColor()
      
    }
    
  }
}


