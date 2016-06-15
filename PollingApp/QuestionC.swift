//
//  QuestionC.swift
//
//
//  Created by James Park on 2016-06-14.
//
//

import Foundation

class QuestionC {
    
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
    
    // getters
    func getQID () -> String {
        return self.QID;
    }
    
    func getAIDS () -> [String]{
        return self.AIDS
    }
    
    func getAuthor () -> String {
        return self.author;
    }
    
    func getQuestionText () -> String{
        return self.questionText
    }
    
    // setters
    func setQID (QID:String)  {
        self.QID = QID;
    }
    
    func setAIDS (AIDS:[String]){
        
            self.AIDS = AIDS;
        
        
       
    }
    
    func setAuthor (author:String)  {
        self.author = author;
    }
    
    func setQuestionText (questionText:String){
        self.questionText = questionText
    }
    
    
    
}