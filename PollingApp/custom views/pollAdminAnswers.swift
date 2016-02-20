//
//  pollAdminAnswers.swift
//  PollingApp
//
//  Created by omar abo baker on 2016-02-19.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class pollAdminAnswers: UIView {

    let screenSize = UIScreen.mainScreen().bounds.size;
    
    var ansArray: NSArray?
    var prcentArray: [Float]?
    
    class func instanceFromNib(frame: CGRect) -> pollAdminAnswers {
        let view = UINib(nibName: "pollAdminAnswers", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! pollAdminAnswers
        view.frame = frame
        
        return view
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(frame:");
    }
    
    init(answersArray:NSArray,percentagesArray:[Float]){
        super.init(frame:CGRectMake(0,0,0,0));
        ansArray = answersArray;
        prcentArray = percentagesArray
    }
    
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        
        self.frame = CGRectMake(0, 0, self.superview!.frame.size.width ,(screenSize.height/8.0)*(CGFloat)(ansArray!.count));
        
        for index in 1...ansArray!.count {
            
            let ansCell:answerCell! = answerCell.init(index: index , text: ansArray!.objectAtIndex(index-1) as! String, percentage: prcentArray![index-1])
            
            ansCell.frame = CGRectMake(0, (screenSize.height/8.0)*((CGFloat)(index-1)), screenSize.width, screenSize.height/8.0);
            
            self.addSubview(ansCell!);
        }
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
