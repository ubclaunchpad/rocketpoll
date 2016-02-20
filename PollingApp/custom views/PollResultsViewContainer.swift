//
//  pollresultsviews.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollResultsViewsContainer: UIView {
    
    class func instanceFromNib(frame: CGRect) -> PollResultsViewsContainer {
        let view = UINib(nibName: "PollResultsViews", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollResultsViewsContainer
        view.frame = frame
        
        return view
    }

}

