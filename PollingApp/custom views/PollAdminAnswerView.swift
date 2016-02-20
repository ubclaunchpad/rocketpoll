
//
//  PollAdminAnswerView.swift
//  PollingApp
//
//  Created by Ahmed Elmaghraby on 2016-02-20.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollAdminAnswerView: UIView {

    
    @IBOutlet var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        UINib.init(nibName: "PollAdminAnswerView", bundle: nil).instantiateWithOwner(self, options: nil)
        
        addSubview(view)
        view.frame = self.bounds
    }

}
