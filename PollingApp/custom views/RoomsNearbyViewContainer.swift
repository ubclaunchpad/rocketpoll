//
//  RoomsNearbyViewContainer.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-03-17.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol RoomsNearbyViewContainerDelegate {
  func roomSelected(room: String)
}

class RoomsNearbyViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  
  //    @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var tableView: UITableView!
  
  private var rooms:[String] = ["Room 1", "Room2"]
  
  var delegate: RoomsNearbyViewContainerDelegate?
  
  class func instancefromNib(frame: CGRect) -> RoomsNearbyViewContainer {
    let view = UINib(nibName: "RoomsNearbyViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0]
      as! RoomsNearbyViewContainer
    view.frame = frame
    view.tableView.delegate = view
    view.tableView.dataSource = view
    return view
  }
  
  func setRooms(roomNames: [String]) {
    rooms = roomNames
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rooms.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let nib_name = UINib(nibName: "RoomViewTableViewCell", bundle: nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "roomCell")
    let cell = self.tableView.dequeueReusableCellWithIdentifier("roomCell", forIndexPath: indexPath) as! RoomViewTableViewCell
    cell.delegate = self
    cell.setRoomNameText(rooms[indexPath.row])
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 90
  }
  
}

extension RoomsNearbyViewContainer: RoomsViewTableViewCellDelegate {
  func roomSelected(room: String) {
    delegate?.roomSelected(room)
  }
}
