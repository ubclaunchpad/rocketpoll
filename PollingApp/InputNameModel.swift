//
//  InputNameModel.swift
//  PollingApp
//
//  Created by Jon Mercer on 2016-02-08.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import UIKit

class InputNameModel {
  //MARK: Properties
  
  var name = ""
  
  
  //MARK: Initialization
  init?(name: String) {
    self.name = name
    
    if(name.characters.count == 0) {
      return nil
    }
  }
}
