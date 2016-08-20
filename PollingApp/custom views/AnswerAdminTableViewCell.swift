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
    @IBOutlet weak var backgroundImage: UIImageView!

  @IBOutlet weak var isCorrectImage: UIImageView!
 
  @IBOutlet weak var Tally: UILabel!
  
  let incorrectImage: UIImage? = UIImage(named: imageNames.setIncorrect)
  
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
    
    if isCorrect == UIStringConstants.notCorrect {
        self.isCorrectImage.image = incorrectImage
    }
  }
  
  func setTallyLabel (tally: Int) {
    self.Tally.text = StringUtil.fillInString(tallyString, time: tally)
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
