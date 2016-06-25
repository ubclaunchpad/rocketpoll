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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAnswerText(answer: AnswerText){
        answerlabel.text = answer
    }
    
    func setisCorrect(isCorrect: String) {
        if isCorrect == "notCorrect" {
           isaCorrectAnswer.text = "not Correct"
        }
        else{
            isaCorrectAnswer.text = "Correct"
        }
    }
    
    
}
