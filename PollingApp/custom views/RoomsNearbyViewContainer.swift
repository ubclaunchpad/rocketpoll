//
//  RoomsNearbyViewContainer.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-03-16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class RoomsNearbyViewContainer: UIView {

    
    @IBOutlet var view: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "RoomsNearbyViewContainer", bundle: nil).instantiateWithOwner(self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
    func updateTableView() {
        tableView.registerNib(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomTableViewCell")
        
    }
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RoomTableViewCell", forIndexPath: indexPath) as! RoomTableViewCell
        
        cell.roomName.text = indexPath.row
        return cell
    }
}
