//
//  AnswerC.swift
//  PollingApp
//
//  Created by James Park on 2016-06-14.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation


class AnswerC {
    var AID = ""
    var isCorrect = false
    var tally = 0
    var answerText = ""
    
    
    init (AID:String, isCorrect:Bool, tally:Int, answerText:String ) {
        self.AID = AID
        self.isCorrect = isCorrect
        self.tally  = tally
        self.answerText = answerText
    }
    
    
    
    func getAID () -> String {
        return self.AID;
    }
    
    func getIsCorrect () -> Bool{
        return self.isCorrect
    }
    
    func getAnswerText () -> String {
        return self.answerText;
    }
    
    func getTally () -> Int {
        return self.tally
    }

}