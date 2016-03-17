//
//  RoomViewTableViewCell.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-03-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    @IBOutlet weak var roomName: UILabel!
    @IBAction func joinButton(sender: AnyObject) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
