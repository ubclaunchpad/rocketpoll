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

  @IBOutlet weak var isCorrectImage: UIImageView!
 
  @IBOutlet weak var Tally: UILabel!
  
  let colour = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5);
  let incorrectImage: UIImage? = UIImage(named: "SetIncorrect")
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
        self.isCorrectImage.image = incorrectImage
    }
  }
  
  func SetTallyLabel (tally: String) {
    self.Tally.text = tally
  }
  func setBarGraph (result:Double) {
    
    for view in self.subviews{
      if (view.backgroundColor == colour) {
        view.removeFromSuperview()
      }
    }
    
    let r = CGFloat(result/100);
    var frame: CGRect = self.frame
    
    frame.size.width = frame.size.width*r //The 0.66 is the percentage as a decimal
    frame.origin.y = self.frame.size.height - frame.size.height //adjust where it should start
    let bg1: UIView = UIView(frame: frame)
    bg1.backgroundColor = colour
    self.addSubview(bg1)
    


  }
  
  
}
