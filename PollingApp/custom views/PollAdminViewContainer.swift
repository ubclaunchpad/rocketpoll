//
//  PollAdminUserViewContainer.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-04-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit

class PollAdminViewContainer: UIView {
    
    class func instanceFromNib(frame: CGRect) -> PollAdminViewContainer {
        let view = UINib(nibName: "PollAdminViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollAdminViewContainer
        view.frame = frame
        return view
    }
}
