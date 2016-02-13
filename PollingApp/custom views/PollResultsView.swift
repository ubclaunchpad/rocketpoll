//
//  pollresultsviews.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollResultsViews: UIView {
    
    class func instanceFromNib(frame: CGRect) -> PollResultsViews {
        let view = UINib(nibName: "PollResultsViews", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollResultsViews
        view.frame = frame
        
        return view
    }
    
    
}

