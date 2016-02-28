//
//  AnswerView.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-02-28.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class AnswerView: UIView {

    @IBOutlet weak var answerButton: UIButton!
    @IBAction func answerButtonPressed(sender: UIButton) {
        if let selectedAnswer = sender.currentTitle {
            print(selectedAnswer)
        }
    }
    
  
    
    
    @IBOutlet var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "AnswerView", bundle: nil).instantiateWithOwner(self, options: nil)
        
        addSubview(view)
        view.frame=self.bounds
        
    }
}
