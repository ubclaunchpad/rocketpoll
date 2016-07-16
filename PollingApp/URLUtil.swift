//
//  URLUtil.swift
//  PollingApp
//
//  Created by Odin on 2016-07-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class URLUtil {
  
  static func getNameFromStringPath(stringPath: String) -> String {
    //URL sees that "+" is a " "
    let stringPath = stringPath.stringByReplacingOccurrencesOfString(" ", withString: "+")
    let url = NSURL(string: stringPath)
    return url!.lastPathComponent!
  }
  
  static func getNameFromURL(url: NSURL) -> String {
    return url.lastPathComponent!
  }
}