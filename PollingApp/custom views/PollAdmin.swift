//
//  PollAdmin.swift
//  PollingApp
//
//  Created by Ahmed Elmaghraby on 2016-02-20.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollAdmin: UIView {

    @IBOutlet var view: PollAdmin!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        UINib.init(nibName: "PollAdmin", bundle: nil).instantiateWithOwner(self, options: nil)
        
        addSubview(view)
        view.frame = self.bounds
    }
    
    func setQuestion(question: String){
        
        questionLabel.text = question;
        
    }

}
