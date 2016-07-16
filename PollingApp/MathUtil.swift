//
//  MathUtil.swift
//  PollingApp
//
//  Created by James Park on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation


class MathUtil  {
  static func convertTallyResultsToPercentage (numerator: Double, denominator: Double) ->  Double{
    let percent = Double(round((Double(numerator/denominator * 100)) * 10 / 10))
    return percent
  }
}