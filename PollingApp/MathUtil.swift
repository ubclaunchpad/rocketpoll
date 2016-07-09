//
//  MathUtil.swift
//  PollingApp
//
//  Created by James Park on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation


class MathUtil  {
  static func calculatePercentage (result:Double) ->  Double{
    let percent = Double(round(10*result)/10)
    return percent
  }
}