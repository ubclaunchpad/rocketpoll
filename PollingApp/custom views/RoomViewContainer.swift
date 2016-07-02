//
//  RoomViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class RoomViewContainer: UIView {
  
  class func instanceFromNib(frame: CGRect) -> RoomViewContainer {
    let view = UINib(nibName: "RoomViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! RoomViewContainer
    view.frame = frame
    
    return view
  }
  
  /*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func drawRect(rect: CGRect) {
   // Drawing code
   }
   */
  
}
