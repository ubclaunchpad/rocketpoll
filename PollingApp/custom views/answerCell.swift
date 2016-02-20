//
//  answerCell.swift
//  PollingApp
//
//  Created by omar abo baker on 2016-02-19.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class answerCell: UIView {

    
    var letterLabel: UILabel! = UILabel.init()
    var ansTextLabel: UILabel! = UILabel.init()
    var ansPercentLabel: UILabel! = UILabel.init()
    
    let screenSize = UIScreen.mainScreen().bounds.size;
    
    
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
        
        letterLabel.text = index.description;
        ansTextLabel.text = text;
        ansPercentLabel.text = percentage.description + "%";
        
    }
    
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        
        letterLabel.adjustsFontSizeToFitWidth = true;
        ansTextLabel.adjustsFontSizeToFitWidth = true;
        ansPercentLabel.adjustsFontSizeToFitWidth = true;
        
        letterLabel.textAlignment = NSTextAlignment.Center
        ansTextLabel.textAlignment = NSTextAlignment.Center
        ansPercentLabel.textAlignment = NSTextAlignment.Center
        
        letterLabel.frame = CGRectMake(0,0 , self.superview!.frame.size.width/4.0, self.superview!.frame.size.height);
        ansTextLabel.frame = CGRectMake(letterLabel.frame.size.width, 0, self.superview!.frame.size.width/2.0, self.superview!.frame.size.height);
        ansPercentLabel.frame = CGRectMake(letterLabel.frame.size.width + ansTextLabel.frame.size.width, 0, self.superview!.frame.size.width/4.0, self.superview!.frame.size.height);
        
        self.addSubview(letterLabel)
        self.addSubview(ansTextLabel)
        self.addSubview(ansPercentLabel)
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
