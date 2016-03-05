//
//  CreateQuestionView.swift
//  PollingApp
//
//  Created by Mohamed Ali on 2016-02-13.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CreateQuestionContainerView: UIView {
    @IBOutlet var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "CreateQuestionContainerView", bundle: nil).instantiateWithOwner(self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
}
