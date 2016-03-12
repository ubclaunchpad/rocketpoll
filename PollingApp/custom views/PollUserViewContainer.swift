//
//  PollUserViewContainer.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol PollUserViewContainerDelegate {
    func answerSelected(answer: Answer)

}

class PollUserViewContainer: UIView {
    var selectedAnswer: String = "";
    
    var delegate: PollUserViewContainerDelegate?
    
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
  
    class func instanceFromNib(frame: CGRect) -> PollUserViewContainer {
        
        let view = UINib(nibName: "PollUserViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollUserViewContainer
        view.frame = frame

        return view
    }
    func setQuestionText(questionText: Question) {
        question.text = questionText;
    }
    func populateAnswerViews(answers: [Answer]) {
        // Proportionate Layout - fits all screens
        let answerViewHeight: CGFloat = 0.15 * bounds.height
        var answerViewFrame = CGRectMake(0, bounds.height*2/5, bounds.width, answerViewHeight)
        
        for answer in answers {
            let answerView = AnswerView.instanceFromNib(answerViewFrame)
            answerView.setAnswerText(answer)
            answerView.delegate = self
            addSubview(answerView)
            
            answerViewFrame.origin.y += answerViewHeight+1
        }
    }
    func updateTimerLabel (secs: Int, mins: Int){
        if (mins==0){
        timerLabel.text = "\(secs)";
        }
        else {
            if secs<10{
              timerLabel.text = "\(mins):0\(secs)";
            }
            else {
                timerLabel.text = "\(mins):\(secs)";
            }
        }
    }
}
extension PollUserViewContainer: AnswerViewDelegate {
    func answerSelected(answer: Answer) {
        print(answer)
        delegate?.answerSelected(answer)
               
    }
}
