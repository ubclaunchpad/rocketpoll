//
//  StringUtil.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-07-09.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

class StringUtil {
    static func fillInString(message: String, time: Int) -> String {
        let returnString = message.stringByReplacingOccurrencesOfString("%1%", withString:  "\(time)")
        return returnString
    }
}