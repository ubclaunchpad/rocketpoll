//
//  File.swift
//  PollingApp
//
//  Created by James Park on 2016-08-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol WhoVotedForViewContainerDelegate {

}
class WhoVotedForContainer: UIView {

  var delegate: WhoVotedForViewContainerDelegate?

  class func instanceFromNib(frame: CGRect) -> WhoVotedForContainer {
    let view = UINib(nibName: "WhoVotedForContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! WhoVotedForContainer
    view.frame = frame
    return view
  }
  
  
}