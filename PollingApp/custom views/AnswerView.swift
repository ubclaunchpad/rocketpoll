//
//  AnswerView.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-02-28.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol AnswerViewDelegate {
    func answerSelected(answer: Answer)
}

class AnswerView: UIView {
    
    var delegate: AnswerViewDelegate?

    @IBOutlet weak var answerButton: UIButton!
   
    @IBAction func answerButtonPressed(sender: UIButton) {
        if let selectedAnswer = sender.currentTitle {
            print(selectedAnswer)
            delegate?.answerSelected(selectedAnswer)
        }
    }
    class func instanceFromNib(frame: CGRect) -> AnswerView {
        let view = UINib(nibName: "AnswerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! AnswerView
        view.frame = frame
        return view
    }
    func setAnswerText(answer: String) {
        answerButton.setTitle(answer, forState: UIControlState.Normal)
    }
}
