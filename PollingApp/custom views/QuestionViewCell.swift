//
//  QuestionViewCell.swift
//  PollingApp
//
//  Created by James Park on 2016-07-19.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import UIKit


class QuestionViewCell: UITableViewCell {
  
  @IBOutlet weak var question: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  func setQuestionLabel (questionText:QuestionText) {
    question.text = questionText
  }
  
}