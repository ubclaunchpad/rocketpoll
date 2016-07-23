//
//  Log.swift
//  PollingApp
//
//  Created by Odin on 2016-07-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class Log {
  static func error(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    let fileName = URLUtil.getNameFromStringPath(classPath)
    print("#### ERROR \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
  }
  
  static func warn(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    let fileName = URLUtil.getNameFromStringPath(classPath)
    print("### WARN \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
  }
  
  static func info(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    let fileName = URLUtil.getNameFromStringPath(classPath)
    print("## INFO \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
  }
  
  static func debug(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    let fileName = URLUtil.getNameFromStringPath(classPath)
    print("# DEBUG \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
  }
  
}