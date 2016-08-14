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
  let CorrectImage: UIImage? = UIImage(named: imageNames.setCorrect)
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
  
  func changeCorrectAnswerColor (){
    self.incorrectImage.image = CorrectImage
  }
  
  //IPA-132
  func setResults (result:Double){
    resultsLabel.text = ("\(result)%")
  }
  func SetTallyLabel (tally: Int) {
    self.tallyNum.text = StringUtil.fillInString(tallyString, time: tally)
  }
  func setBarGraph (result:Double, isYourAnswer: Bool) {
    
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
    
    frame.size.width = frame.size.width * percentage - 20
    frame.origin.x = 10
    frame.origin.y = self.frame.size.height - frame.size.height
    let barGraph: UIView = UIView(frame: frame)
    barGraph.layer.cornerRadius = 12
    if isYourAnswer {
      barGraph.backgroundColor = colors.graphBackgroundRed
    } else {
      barGraph.backgroundColor = colors.graphBackgroundGrey
    }
    print(self.subviews)
    self.insertSubview(barGraph, atIndex: 0)
//      self.addSubview(barGraph)
  }
}
