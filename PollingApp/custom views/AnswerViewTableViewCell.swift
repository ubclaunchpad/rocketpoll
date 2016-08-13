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
  
  override var selected: Bool {
    get {
      return super.selected
    }
    set {
      if !newValue {
        super.selected = newValue
        backgroundImage.image = UIImage(named: "AnswerCell")!
        answer.textColor = colors.textColor
      } else {
        super.selected = newValue
        backgroundImage.image = UIImage(named: "AnswerCellSelected")!
        answer.textColor = UIColor.whiteColor()

      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setAnswerText(setAnswer: String) {
    answer.text = setAnswer
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


