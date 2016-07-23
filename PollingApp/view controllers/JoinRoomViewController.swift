//
//  JoinRoomViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

// TODO: Grace is working here

import UIKit

//TODO: IPA-128. Also delete form Main Storyboard
class JoinRoomViewController: UIViewController {
  
  var container: RoomViewContainer?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  func setup() {
    container = RoomViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    view.addSubview(container!)
  }
}
