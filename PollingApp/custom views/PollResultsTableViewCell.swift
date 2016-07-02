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
  
  @IBOutlet weak var resultsLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setAnswerText(answer: AnswerText) {
    answerLabel.text = answer
  }
  
  func changeCorrectAnswerColor (){
    self.backgroundColor = UIColor.greenColor()
  }
  
  //IPA-132
  func setResults (result:Double){
    let percent = Double(round(10*result)/10)
    resultsLabel.text = ("\(percent)%")
  }
}
