//
//  NameModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

protocol NameModelProtocol {
  
  func setUserName(name: String, userID: String)
  
  func cleanName(name: String) -> String
}
