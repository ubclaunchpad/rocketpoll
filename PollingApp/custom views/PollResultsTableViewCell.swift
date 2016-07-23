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
  func SetTallyLabel (tally: String) {
    self.tallyNum.text = tally
  }
  func setBarGraph (result:Double) {
    
    for view in self.subviews{
      if (view.backgroundColor == colors.barGraphColour) {
        view.removeFromSuperview()
      }
    }
    
    let percentage = CGFloat(result/100);
    var frame: CGRect = self.frame
    
    frame.size.width = frame.size.width * percentage
    frame.origin.y = self.frame.size.height - frame.size.height
    let barGraph: UIView = UIView(frame: frame)
    barGraph.backgroundColor = colors.barGraphColour
    self.addSubview(barGraph)
    
  }
}
