//
//  CampaignView.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CampaignViewTableViewCellDelegate {
    func questionSelected(question: Question)
}

class CampaignViewTableViewCell: UITableViewCell {


    @IBOutlet weak var button: UIButton!

    @IBAction func buttonPressed(sender: AnyObject) {
        print("hi")
    }

    var delegate: CampaignViewTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    func setQuestionText(questionName: Question) {
        button.setTitle(questionName, forState: UIControlState.Normal)
    }

}
