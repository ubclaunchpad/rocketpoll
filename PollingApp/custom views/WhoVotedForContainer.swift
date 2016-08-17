//
//  File.swift
//  PollingApp
//
//  Created by James Park on 2016-08-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol WhoVotedForViewContainerDelegate {
  
}
class WhoVotedForContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var questionText: UILabel!
  @IBOutlet weak var answerText: UILabel!
  
  @IBOutlet weak var TableOfUsers: UITableView!
  var delegate: WhoVotedForViewContainerDelegate?
  var listOfUsers = [Author]()
  
  class func instanceFromNib(frame: CGRect) -> WhoVotedForContainer {
    let view = UINib(nibName: "WhoVotedForContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! WhoVotedForContainer
    view.frame = frame
    view.TableOfUsers.delegate = view
    view.TableOfUsers.dataSource = view
    view.TableOfUsers.allowsSelection = false
    view.TableOfUsers.separatorStyle = UITableViewCellSeparatorStyle.None
    view.TableOfUsers.backgroundColor = UIColor.clearColor()
    view.TableOfUsers.opaque = false
    return view
  }
  
  
  func setTextForQuestionLabel (questionText:QuestionText) {
    self.questionText.text = questionText
  }
  
  func setTextForAnswerLabel (answerText:AnswerText) {
    self.answerText.text = answerText
  }
  
  func setListUsers (listOfUsers:[Author]) {
    self.listOfUsers = listOfUsers
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (listOfUsers.isEmpty) {
      return 1
    }

    return listOfUsers.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 84
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let userCell = UINib(nibName: "UserViewTableViewCell", bundle: nil)
    tableView.registerNib(userCell, forCellReuseIdentifier: "usercell")

    let cell = tableView.dequeueReusableCellWithIdentifier("usercell", forIndexPath: indexPath) as! UserViewTableViewCell
    
    if (listOfUsers.isEmpty) {
      cell.setUserNameLabel("No one has voted for this answer")
    } else {
      cell.setUserNameLabel(listOfUsers[indexPath.row])
    }
    return cell
  }
}

extension WhoVotedForContainer: UserViewTableViewCellDelegate {
  
  
}