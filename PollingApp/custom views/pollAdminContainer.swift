//
//  pollAdminContainer.swift
//  PollingApp
//
//  Created by Ahmed Elmaghraby on 2016-02-19.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class pollAdminContainer: UIView {
    
    
    
    class func instanceFromNib(frame: CGRect) -> pollAdminContainer {
        let view = UINib(nibName: "pollAdminView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! pollAdminContainer
        view.frame = frame
        
        return view
    }
    
    func addAnswerView(){
        
        let answerView:pollAdminAnswers = pollAdminAnswers.init(answersArray: ["dummy answer one","dummy answer two","dummy answer three","all of the above"],percentagesArray:[75,3,2,1]);
        
        self.addSubview(answerView);
        
    }
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        
        addAnswerView();
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
