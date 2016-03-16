//
//  PollUserViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/13/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit


final class PollUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var answerIDDictionary = [Answer: AnswerID]()
    
    var tableView: UITableView  =   UITableView()
    
    private var min:Int = 0;
    private var sec = 0;
    private var seconds = 0;
    private var timer = NSTimer();
     var numAnswers = 0;
    var answers:[Answer] = []
    var answerIDs:[AnswerID] = []
    
    private var questionID:QuestionID = ""
    
    var container: PollUserViewContainer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
      
        tableView.frame = CGRectMake(0, view.frame.size.height*0.25, view.frame.size.width, view.frame.size.height);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.registerClass(AnswerViewTableViewCell.self, forCellReuseIdentifier: "answerCell");
        self.tableView.rowHeight = 70
        //TODO: add seperator lines
        

        self.view.addSubview(tableView);

    }
    
    func setup() {
        
        
        
        // add your container class to view
        container = PollUserViewContainer.instanceFromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        
        
        questionID = ModelInterface.sharedInstance.getQuestionID()
        let questionText: Question = ModelInterface.sharedInstance.getQuestion(questionID)
         answerIDs = ModelInterface.sharedInstance.getListOfAnswerIDs(questionID)
        
        container?.setQuestionText(questionText);
        container?.delegate = self
        answers = getAnswers(answerIDs)
        createTimer(ModelInterface.sharedInstance.getCountdownSeconds());
    }
    
    func getAnswers(answerIDs: [AnswerID]) -> [Answer] {
        // Changes the list of answerIDs to list of answers
        var answers = [String]();
        numAnswers = answerIDs.count;
        var temp_answer:Answer;
        
        for answerID in answerIDs {
            temp_answer = ModelInterface.sharedInstance.getAnswer(answerID)
            answers.append(temp_answer)
            answerIDDictionary[temp_answer] = answerID
        }
        return answers
    }
    
    func createTimer (startingTime: Int) {
        seconds = startingTime;
        let min_temp:Int = seconds/60;
        let sec_temp = seconds-60*(min_temp);
        container?.updateTimerLabel(sec_temp, mins: min_temp)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("updateTimer"), userInfo: nil, repeats: true);
        
    }
    
    
    
    func updateTimer (){
        
        if(seconds>0){
        seconds--
            min = seconds/60;
            sec = seconds - 60*min;
        container?.updateTimerLabel(sec,mins: min)
        }else{
            timer.invalidate();
            // TODO: SEGUE to next view
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numAnswers;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let nib_name = UINib(nibName: "AnswerViewTableViewCell", bundle:nil)
        tableView.registerNib(nib_name, forCellReuseIdentifier: "answerCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath)
       //cell.textLabel?.text = answers[indexPath.row];
        container?.setAnswerLabel(answers[indexPath.row]);
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ModelInterface.sharedInstance.setUserAnswer(questionID, answerID: answerIDs[indexPath.row]);
        
    }

    
}//PollUserViewControllerClass




extension PollUserViewController: PollUserViewContainerDelegate {
    func answerSelected(answer: Answer) {
        if let selectedAnswerID = answerIDDictionary[answer] {
            ModelInterface.sharedInstance.setUserAnswer(questionID, answerID: selectedAnswerID)
        }
    }
    
}
