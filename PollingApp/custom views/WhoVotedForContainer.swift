//
//  File.swift
//  PollingApp
//
//  Created by James Park on 2016-08-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol WhoVotedForViewContainerDelegate {

}
class WhoVotedForContainer: UIView, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var questionText: UILabel!
  @IBOutlet weak var answerText: UILabel!
  
  @IBOutlet weak var TableOfUsers: UITableView!
  var delegate: WhoVotedForViewContainerDelegate?

  class func instanceFromNib(frame: CGRect) -> WhoVotedForContainer {
    let view = UINib(nibName: "WhoVotedForContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! WhoVotedForContainer
    view.frame = frame
    return view
  }
  
  
  func setTextForQuestionLabel (questionText:QuestionText) {
    self.questionText.text = questionText
  }
  
  func setTextForAnswerLabel (answerText:AnswerText) {
    self.answerText.text = answerText
  }
  
  
}