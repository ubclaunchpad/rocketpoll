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
}

class AnswerTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var correctButton: UIButton!
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
            }
        }
    }
    
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
