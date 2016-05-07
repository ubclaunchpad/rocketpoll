//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CreateQuestionViewContainerDelegate {
  func submitButtonPressed()
 
}


class CreateQuestionContainerView: UIView {
  @IBOutlet weak var Submit: UIButton!
    var delegate: CreateQuestionViewContainerDelegate?
  
  @IBAction func SubmitPress(sender: AnyObject) {
    print("Hello")
    delegate?.submitButtonPressed();
    
      
  }
  
  
  
    @IBOutlet var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        
    }
  

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


