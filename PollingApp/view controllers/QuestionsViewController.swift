//
//  FirstViewController.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  let questionsViewContainer: QuestionsViewContainer
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    questionsViewContainer = QuestionsViewContainer()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    questionsViewContainer = QuestionsViewContainer()
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    tableView.delegate = self
//    tableView.dataSource = self
    populateQuestions()
  }
  
  override func viewWillLayoutSubviews() {
    var buffer: CGFloat = 0

    if let tabBarController = self.tabBarController {
      buffer = tabBarController.tabBar.bounds.height
    }
    questionsViewContainer.updateSubviewsForNewOrientation(view.bounds.width, height: view.bounds.height, buffer: buffer)
  }
  
  func populateQuestions() {
    // TODO: Create model to handle data. Have the model return questions even if they are hardcoded (like below) for now
    var questions: [Question] = []
    for i in 0..<20 {
      questions += ["Question \(i+1)"]
    }
    questionsViewContainer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    questionsViewContainer.populateQuestionViews(questions)
    view.addSubview(questionsViewContainer)
  }
  
}


extension QuestionsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.textLabel?.text = "Question"
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return 5
  }
}

extension QuestionsViewController: UITableViewDelegate {
  
}

