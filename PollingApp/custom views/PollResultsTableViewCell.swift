//
//  PollResultsTableViewCell.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-03-24.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollResultsTableViewCell: UITableViewCell{
  
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var incorrectImage: UIImageView!
  
  @IBOutlet weak var resultsLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  @IBOutlet weak var tallyNum: UILabel!
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setAnswerText(answer: AnswerText) {
    answerLabel.text = answer
  }
  
  func setCorrectAnswer(){
    self.incorrectImage.image = images.correct
  }
  
  func setCorrectAnswerSelected() {
    self.incorrectImage.image = images.correctSelected
  }
  
  func selectedCorrectly() {
    answerLabel.textColor = UIColor.whiteColor()
    tallyNum.textColor = UIColor.whiteColor()
  }
  
  //IPA-132
  func SetTallyLabel (tally: Int, result: Double) {
    self.tallyNum.text = "\(StringUtil.fillInString(tallyString, time: tally))  |  \(result)%"
  }
  func setBarGraph (result:Double, isYourAnswer: Bool, isCorrect: Bool) {
    
    for view in self.subviews{
      if (view.backgroundColor == colors.graphBackgroundRed || view.backgroundColor == colors.graphBackgroundGrey) {
        view.removeFromSuperview()
      }
    }
    
    guard result > 0 else {
      return
    }
    
    let percentage = CGFloat(result/100);
    var frame: CGRect = self.frame
    
    frame.size.width = frame.size.width * percentage - 22
    frame.size.height = frame.size.height - 5
    frame.origin.x = 10
    frame.origin.y = 1
    let barGraph: UIView = UIView(frame: frame)
    barGraph.layer.cornerRadius = 8
    if isYourAnswer {
      barGraph.backgroundColor = colors.graphBackgroundRed
      selectedCorrectly()
      if isYourAnswer && isCorrect {
        setCorrectAnswerSelected()
      }
    } else {
      barGraph.backgroundColor = colors.graphBackgroundGrey
    }
    self.subviews.first?.insertSubview(barGraph, atIndex: 2)
  }
}
