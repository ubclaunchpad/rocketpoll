//
//  QuestionC.swift
//
//
//  Created by James Park on 2016-06-14.
//
//

import Foundation

class Question {
    
    var QID = "";
    var AIDS = [String()];
    var author = "";
    var questionText = "";
    
    init() {
        
    }
    
    init (QID: String, AIDS:[String], author:String, questionText:String) {
        
        self.QID = QID;
        self.AIDS = AIDS;
        self.author = author;
        self.questionText = questionText
    }
  
}