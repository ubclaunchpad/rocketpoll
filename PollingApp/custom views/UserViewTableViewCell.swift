//
//  UserViewTableViewCell.swift
//  PollingApp
//
//  Created by James Park on 2016-08-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit
protocol UserViewTableViewCellDelegate {
}
class UserViewTableViewCell: UITableViewCell {

  @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setUserNameLabel (userName: Author) {
    self.userName.text = userName
  }
}
