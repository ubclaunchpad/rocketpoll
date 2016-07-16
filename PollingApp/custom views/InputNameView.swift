//
//  InputNameView.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-07-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit

protocol InputNameViewDelegate {
  
}

class InputNameView: UIView {
  
  var delegate: InputNameViewDelegate?
  
  class func instanceFromNib(frame: CGRect) -> InputNameView {
    let view = UINib(nibName: "InputNameView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! InputNameView
    view.frame = frame
    
    return view
  }

  
}

