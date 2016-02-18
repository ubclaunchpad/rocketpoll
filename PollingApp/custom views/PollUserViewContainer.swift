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
        //var i = 0;
        var buttonY: CGFloat = self.frame.size.height*0.2  // starting offset
        for answer in answerArray {
            
            let rectSize = self.frame.size.height*0.6 / CGFloat(answerArray.count)
            
            
            
            
            let answerButton = UIButton(frame: CGRect(x: self.frame.size.width*0.1, y: buttonY, width: self.frame.size.width*0.8, height: rectSize))
            buttonY = buttonY + rectSize+20
            
            //answerButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            answerButton.layer.cornerRadius = 10
            answerButton.backgroundColor = UIColor.blueColor()
            answerButton.setTitle(answer, forState: UIControlState.Normal) // We are going to use the item name as the Button Title here.
            answerButton.titleLabel?.text = answer;
            answerButton.addTarget(self, action: "answerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            
            self.addSubview(answerButton)
         
        }
    
    }//set answers function
    
    
    func answerButtonPressed(sender:UIButton!) {
        
        if sender.titleLabel?.text != nil {
            print("You have chosen : \(sender.titleLabel?.text)")
        } else {
            
            print("Nowhere to go :/")
            
        }
        
    }
    
    
   
    
}