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
  
  
  @IBOutlet var answer1: UIButton!
  @IBOutlet var answer2: UIButton!
  @IBOutlet var answer3: UIButton!
  @IBOutlet var answer4: UIButton!
  @IBOutlet var selectedAnswerLabel: UILabel!
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
    
    
    func populateAnswerViews(answers: [String]) {
        let answerViewHeigh: CGFloat = 100
        var answerViewFrame = CGRectMake(0, 0, bounds.width, answerViewHeigh)
        
        for answer in answers {
            let answerView = AnswerView.instanceFromNib(answerViewFrame)
            answerView.setAnswerText(answer)
            addSubview(answerView)
            
            answerViewFrame.origin.y += answerViewHeigh
        }
       
    }

    
    
    
    
    
    
    
//  func setAnswers(answerArray: [String]) {
//    //var i = 0;
//    var buttonY: CGFloat = self.frame.size.height*0.2  // starting offset
//    for answer in answerArray {
//      
//      let rectSize = self.frame.size.height*0.6 / CGFloat(answerArray.count)
//      
//      
//      
//      
//      let answerButton = UIButton(frame: CGRect(x: self.frame.size.width*0.1, y: buttonY, width: self.frame.size.width*0.8, height: rectSize))
//      buttonY = buttonY + rectSize+20
//      
//      //answerButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//      answerButton.layer.cornerRadius = 10
//      answerButton.backgroundColor = UIColor.blueColor()
//      answerButton.setTitle(answer, forState: UIControlState.Normal) // We are going to use the item name as the Button Title here.
//      answerButton.titleLabel?.text = answer;
//      answerButton.addTarget(self, action: "answerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//      
//      
//      self.addSubview(answerButton)
//      
//    }
//    
//  }//set answers function
//  
//  
//  func answerButtonPressed(sender:UIButton!) {
//    
//    if sender.titleLabel?.text != nil {
//      print("You have chosen : \(sender.titleLabel?.text)")
//    } else {
//      
//      print("Nowhere to go :/")
//      
//    }
//    
//  }
  
  
  
  
}