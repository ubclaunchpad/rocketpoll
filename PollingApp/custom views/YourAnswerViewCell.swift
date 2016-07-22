//
//  YourAnswerViewCell.swift
//  PollingApp
//
//  Created by James Park on 2016-07-20.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation
import UIKit


class YourAnswerViewCell: UITableViewCell {
  
  @IBOutlet weak var results: UILabel!
  @IBOutlet weak var correctAnswer: UIImageView!
  @IBOutlet weak var yourAnswerLabel: UILabel!
  let CorrectImage: UIImage? = UIImage(named: imageNames.setCorrect)
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  func changeCorrectAnswerColor (){
    self.correctAnswer.image = CorrectImage
  }
  func setYourAnswer (yourAnswer:String){
    yourAnswerLabel.text = yourAnswer
  }
  //IPA-132
  func setResult (result:Double){
    results.text = ("\(result)%")
  }
  
}