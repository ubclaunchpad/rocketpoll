//
//  PollUserViewContainer.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollUserViewContainer: UIView {
//    var selectedAnswer: String = "";
//    
    @IBOutlet weak var question: UILabel!

    @IBAction func answerPressed(sender: UIButton) {
        if let selectedAnswer = sender.currentTitle {
            print(selectedAnswer)
        }
    }
    class func instanceFromNib(frame: CGRect) -> PollUserViewContainer {
        let view = UINib(nibName: "PollUserViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollUserViewContainer
        view.frame = frame
        
        return view
    }
    
    func setHeaderText(questionText: Question) {
        question.text = questionText;
        
    }
//    
//    func getAnswer() -> String {
//        return selectedAnswer;
//    }
    
    func setAnswers(answers: [String]) {
        for i in 1...answers.count {
            
            //TODO: create a new button for each answer in the list
            
            let quest = UIButton();
            
            
        }
    }
    
   
    
}