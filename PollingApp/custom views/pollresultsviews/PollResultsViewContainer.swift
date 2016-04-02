//
//  pollresultsviews.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class PollResultsViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    class func instanceFromNib(frame: CGRect) -> PollResultsViewContainer {
        let view = UINib(nibName: "PollResultsViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollResultsViewContainer
        view.frame = frame
        view.resultsTableView.delegate = view
        view.resultsTableView.dataSource = view
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let pollResultsCell = UINib(nibName: "PollResultsTableViewCell", bundle: nil)
        tableView.registerNib(pollResultsCell, forCellReuseIdentifier: "resultsCell")
        let cell = self.resultsTableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //TODO set to number of answers
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}
