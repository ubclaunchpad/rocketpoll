//
//  PollUserViewContainer.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollUserViewContainer: UIView {
    var selectedAnswer: String = "";
    
    @IBOutlet weak var question: UILabel!

    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var selectedAnswerLabel: UILabel!
    @IBAction func answerPressed(sender: UIButton) {
        if let selectedAnswer = sender.currentTitle {
            selectedAnswerLabel.text = selectedAnswer
            print(selectedAnswer)
        }
    }
    class func instanceFromNib(frame: CGRect) -> PollUserViewContainer {
        let view = UINib(nibName: "PollUserViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollUserViewContainer
        view.frame = frame
        
        return view
    }
    
    func setQuestionText(questionText: Question) {
        question.text = questionText;
    }
    
    func getAnswer() -> String {
        return selectedAnswer;
    }
    
    func setAnswers(answers: [String]) {
        var answerButtons = [answer1, answer2, answer3, answer4]
        for i in 0..<answers.count {
            answerButtons[i].setTitle(answers[i], forState: UIControlState.Normal)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}