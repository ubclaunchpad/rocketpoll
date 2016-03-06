//
//  ModelInterface.swift
//  PollingApp
//
//  Created by Jon on 2016-03-03.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation
/**
 All controllers must use this class to get get and set data along with find out where to segue to next.
 
 Do the following to use the class: Modelinterface.sharedInstance.<functionName>
 
 See *ModelProtocol.swift files for functions supported by ModelInterface.
*/
class ModelInterface {
  static let sharedInstance = ModelInterface()
}
