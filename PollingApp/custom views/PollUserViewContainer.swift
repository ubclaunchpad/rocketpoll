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

class PollUserViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
  
  var selectedAnswer: String = "";
  
  //var tableView: UITableView  =   UITableView()
  var delegate: PollUserViewContainerDelegate?
  /*
  tableView.frame = CGRectMake(0, view.frame.size.height*0.25, view.frame.size.width, view.frame.size.height);
  tableView.delegate = self;
  tableView.dataSource = self;
  tableView.registerClass(AnswerViewTableViewCell.self, forCellReuseIdentifier: "answerCell");
  self.tableView.rowHeight = 70
  //TODO: add seperator lines
  
  self.view.addSubview(tableView);
  */
  
  @IBOutlet weak var question: UILabel!
  
  @IBOutlet weak var timerLabel: UILabel!
  
  class func instanceFromNib(frame: CGRect) -> PollUserViewContainer {
    let view = UINib(nibName: "PollUserViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollUserViewContainer
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    return view
  }
  
  func setQuestionText(questionText: Question) {
    question.text = questionText;
  }
  
  func updateTimerLabel(secs: Int, mins: Int) {
    if (mins==0){
      timerLabel.text = "\(secs)";
    } else {
      if secs<10{
        timerLabel.text = "\(mins):0\(secs)";
      } else {
        timerLabel.text = "\(mins):\(secs)";
      }
    }
    
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10;
    
    //return numAnswers;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let nib_name = UINib(nibName: "AnswerViewTableViewCell", bundle:nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "answerCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath)
    cell.textLabel?.text = "tesing"
    
    //container?.setAnswerLabel(answers[indexPath.row]);
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // ModelInterface.sharedInstance.setUserAnswer(questionID, answerID: answerIDs[indexPath.row]);
    
  }
}

extension PollUserViewContainer: AnswerViewTableViewCellDelegate {
  func answerSelected(answer: Answer) {
    print(answer)
    delegate?.answerSelected(answer)
    
  }
}
