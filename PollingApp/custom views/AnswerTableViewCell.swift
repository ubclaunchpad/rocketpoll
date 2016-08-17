//
//  AnswerTableViewCell.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-07-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import UIKit

protocol AnswerTableViewCellDelegate {
  func updateAnswer(identifier: Int, answer: String)
  func updateCorrectAnswer(identifier: Int)
  func deselectAnswer()
}

class AnswerTableViewCell: UITableViewCell {
  @IBOutlet weak var answerField: UITextField!
  @IBOutlet weak var correctButton: UIButton!
  @IBOutlet weak var backgroundImage: UIImageView!
  
  var identifier:Int?
  var delegate:AnswerTableViewCellDelegate?
  @IBAction func correct(sender: UIButton) {
    if isCorrect! {
      isCorrect = false
    } else {
      isCorrect = true
    }
  }
  
  var isCorrect:Bool? {
    didSet {
      if isCorrect! {
        correctButton.setImage(UIImage(named: "SetCorrect")!, forState: .Normal)
        delegate?.updateCorrectAnswer(identifier!)
        
      } else {
        correctButton.setImage(UIImage(named: "SetIncorrect")!, forState: .Normal)
        delegate?.deselectAnswer()
      }
    }
  }
  
  func textFieldDidChange(textField: UITextField) {
    let answer = StringUtil.trimString(textField.text!)
    delegate?.updateAnswer(identifier!, answer: answer)
  }
}
