//
//  RoomViewTableViewCell.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-03-18.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class RoomViewTableViewCell: UITableViewCell {

    @IBOutlet weak var roomName: UIButton!
   
    @IBAction func roomSelected(sender: AnyObject) {
        if let selectedRoom = sender.currentTitle {
            print(selectedRoom)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRoomNameText(name: String) {
        roomName.setTitle(name, forState: UIControlState.Normal)
    }
    
}
