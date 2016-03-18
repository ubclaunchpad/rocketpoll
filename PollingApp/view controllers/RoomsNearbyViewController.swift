//
//  RoomsNearbyViewController.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-03-15.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class RoomsNearbyViewController: UIViewController {
    
    var container: RoomsNearbyViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        container = RoomsNearbyViewContainer.instancefromNib(CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(container!)
        
        let rooms = getRooms(ModelInterface.sharedInstance.getRoomsNeaby())
        container?.setRooms(rooms)
        
    }
    
    func getRooms(roomIDs: [String]) -> [String] {
        var temp_rooms = [String]()
        var temp_room_name:String
        for roomID in roomIDs {
            temp_room_name = ModelInterface.sharedInstance.getRoomName(roomID)
            temp_rooms.append(temp_room_name)
        }
        return temp_rooms
    }
}
