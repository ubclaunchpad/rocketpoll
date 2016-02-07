//
//  DynamicScrollView.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/7/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class DynamicScrollView: UIScrollView {
  let subviewClass: AnyClass
  
  init(aClass: AnyClass) {
    subviewClass = aClass
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    defineScrollBehaviors()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(aClass: object_getClass(UIView()))
    defineScrollBehaviors()
  }
  
  func updateContentSize(var height: CGFloat) {
    if height < bounds.height {
      height = bounds.height
    }
    contentSize = CGSize(width: frame.size.width, height: height)
  }
  
  func defineScrollBehaviors() {
    alwaysBounceVertical = true
    showsVerticalScrollIndicator = true
    autoresizesSubviews = false
  }
  
  func updateSubviewsForNewOrientation(width: CGFloat, height: CGFloat, buffer: CGFloat) {
    frame.size = CGSize(width: width, height: height)
    
    var yPos: CGFloat = 0
    for subview in subviews {
      if subview.isKindOfClass(subviewClass) {
        subview.frame.size.width = width
        yPos += subview.bounds.height
      }
    }
    updateContentSize(yPos + buffer)
  }
  
}
