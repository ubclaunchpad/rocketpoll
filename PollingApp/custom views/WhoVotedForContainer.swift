//
//  File.swift
//  PollingApp
//
//  Created by James Park on 2016-08-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class WhoVotedForContainerView: UIView {


  class func instancefromNib(frame: CGRect) -> WhoVotedForContainerView {
    let view = UINib(nibName: "WhoVotedForContainerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! WhoVotedForContainerView
    view.frame = frame
    return view
  }
  
  
}