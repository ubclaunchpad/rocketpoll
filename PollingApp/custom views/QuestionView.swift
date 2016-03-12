//
//  QuestionView.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class QuestionView: UIView {
  
  @IBOutlet private weak var questionLabel: UILabel!
  
  class func instanceFromNib(frame: CGRect) -> QuestionView {
    let view = UINib(nibName: "QuestionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! QuestionView
    view.frame = frame
    return view
  }
  
  func setQuestionText(question: Question) {
    questionLabel.text = question
  }
  
}
