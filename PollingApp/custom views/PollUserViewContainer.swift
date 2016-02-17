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
    
    func setAnswers(answerArray: [String]) {
        var i = 0;
        var buttonY: CGFloat = 20  // starting offset
        for answer in answerArray {
            
            i = i+1;
            let answerButton = UIButton(frame: CGRect(x: 50, y: buttonY, width: 250, height: 30))
            buttonY = buttonY + 50  // we are going to space these UIButtons 50px apart
            
            //answerButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            answerButton.layer.cornerRadius = 10
            answerButton.backgroundColor = UIColor.blueColor();
            answerButton.setTitle(answer, forState: UIControlState.Normal) // We are going to use the item name as the Button Title here.
            answerButton.titleLabel?.text = answer;
            answerButton.addTarget(self, action: "answerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(answerButton)  // myView in this case is the view you want these buttons added
            print("this code worked");
        }
    
    
    
    }//set answers function
    
    
    
   
    
}