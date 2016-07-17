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
}

class AnswerTableViewCell: UITableViewCell, UITextFieldDelegate {
  @IBOutlet weak var answerField: UITextField!
  var identifier:Int?
  var delegate:AnswerTableViewCellDelegate?
  
  func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    let answer = StringUtil.trimString(textField.text!)
    if answer != "" && ModelInterface.sharedInstance.isValidName(answer){
      delegate?.updateAnswer(identifier!, answer: answer)
    }
    return true
  }
}
