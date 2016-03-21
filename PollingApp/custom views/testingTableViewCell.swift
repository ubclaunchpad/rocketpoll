//
//  testingTableViewCell.swift
//  PollingApp
//
//  Created by Cyrus Behroozi on 2016-03-15.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class testingTableViewCell: UITableViewCell {
    @IBOutlet weak var testing: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    class func instanceFromNib(frame: CGRect) -> testingTableViewCell {
        let view = UINib(nibName: "testing", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! testingTableViewCell
        view.frame = frame
        return view
    
    
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
