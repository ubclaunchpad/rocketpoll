//
//  QuestionResultViewCell.swift
//  PollingApp
//
//  Created by James Park on 2016-07-20.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import UIKit


class QuestionResultViewCell: UITableViewCell {
  
  @IBOutlet weak var questionLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  func displayQuestion (questionText:QuestionText) {
    questionLabel.text = questionText
  }

}