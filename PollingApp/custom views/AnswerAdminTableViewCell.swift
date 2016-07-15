//
//  AnswerAdminTableViewCell.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-04-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class AnswerAdminTableViewCell: UITableViewCell {
  
  @IBOutlet weak var answerlabel: UILabel!
  @IBOutlet weak var isaCorrectAnswer: UILabel!
  @IBOutlet weak var Tally: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setAnswerText(answer: AnswerText){
    answerlabel.text = answer
  }
  func changeCorrectAnswerColor (){
    self.backgroundColor = UIColor.redColor()
  }
  func setisCorrect(isCorrect: String) {
    //TODO: this should no be a magic string
    if isCorrect == "notCorrect" {
      isaCorrectAnswer.text = "\(correct.notCorrect)"
    }
    else{
      isaCorrectAnswer.text = "\(correct.isCorrect)"
    }
  }
  
  func SetTallyLabel (tally: String) {
    self.Tally.text = tally
  }
  
  
}
