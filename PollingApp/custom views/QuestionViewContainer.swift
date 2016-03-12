//
//  QuestionViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class QuestionsViewContainer: DynamicScrollView {
  
  init() {
    super.init(aClass: object_getClass(QuestionView()))
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  func populateQuestionViews(questions: [Question]) {
    let questionViewHeight: CGFloat = 100
    var questionViewFrame = CGRectMake(0, 0, bounds.width, questionViewHeight)
    
    for question in questions {
      let questionView = QuestionView.instanceFromNib(questionViewFrame)
      questionView.setQuestionText(question)
      addSubview(questionView)
      
      questionViewFrame.origin.y += questionViewHeight
    }
    updateContentSize(questionViewFrame.origin.y + questionViewHeight)
  }
  
}
