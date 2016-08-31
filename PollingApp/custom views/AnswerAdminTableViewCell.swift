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
  
  func setisCorrect(isCorrect: String) {
    //TODO: this should no be a magic string
    
    if isCorrect == UIStringConstants.notCorrect {
        self.isCorrectImage.hidden = true
    } else {
      self.isCorrectImage.hidden = false
    }
  }
  
  func setTallyLabel (tally: Int) {
    self.Tally.text = StringUtil.fillInString(tallyString, time: tally)
  }
  
  func setBarGraph (result:Double) {
    
    for view in self.subviews{
      if (view.backgroundColor == colors.graphBackgroundGrey) {
        view.removeFromSuperview()
      }
    }
    
    guard result > 0 else {
      return
    }
    
    let percentage = CGFloat(result/100);
    var frame: CGRect = self.frame
    
    frame.size.width = abs(frame.size.width * percentage - 20)
    frame.size.height = frame.size.height - 6
    frame.origin.x = 10
    frame.origin.y = 1
    let barGraph: UIView = UIView(frame: frame)
    barGraph.layer.cornerRadius = 12
    barGraph.backgroundColor = colors.graphBackgroundGrey 
    self.addSubview(barGraph)

    
  }
  
  
}
