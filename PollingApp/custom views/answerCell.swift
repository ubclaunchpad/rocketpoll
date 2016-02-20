//
//  answerCell.swift
//  PollingApp
//
//  Created by omar abo baker on 2016-02-19.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class answerCell: UIView {

    
    @IBOutlet weak var letterLabel: UILabel?
    @IBOutlet weak var ansTextLabel: UILabel?
    @IBOutlet weak var ansPercentLabel: UILabel? 
    
    
    
    class func instanceFromNib(frame: CGRect) -> answerCell {
        let view = UINib(nibName: "answerCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! answerCell
        view.frame = frame
        
        return view
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(frame:");
    }
    
    
    init(index:Int ,text:String,percentage:Float){
        super.init(frame: CGRectMake(0, 0, 0, 0));
        
        letterLabel?.text = index.description;
        ansTextLabel?.text = text;
        ansPercentLabel?.text = percentage.description + "%";
        
    }
    
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        if self.superview == nil {
            return
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
