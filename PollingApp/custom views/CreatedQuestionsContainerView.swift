//
//  CreatedQuestionsContainerView.swift
//  PollingApp
//
//  Created by Ali Haghani on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CreatedQuestionsContainerView: UIView {
    
    
    class func instanceFromNib(frame: CGRect) -> CreatedQuestionsContainerView {
        let view = UINib(nibName: "CreatedQuestionsContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CreatedQuestionsContainerView
        view.frame = frame
        
        return view
    }
    
    func setQuetions(questions:[Question]){
        
    }


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
