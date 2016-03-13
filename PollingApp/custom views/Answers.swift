//
//  Answers.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-03-12.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit

class Answers: UIView {
    
    @IBOutlet var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       UINib(nibName: "Answers", bundle: nil).instantiateWithOwner(self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
}
