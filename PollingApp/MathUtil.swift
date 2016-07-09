//
//  MathUtil.swift
//  PollingApp
//
//  Created by James Park on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation


class MathUtil  {
  static func calculatePercentage (num:Double, denom:Double) ->  Double{
    let percent = Double(round((Double(num/denom * 100)) * 10 / 10))
    return percent
  }
}