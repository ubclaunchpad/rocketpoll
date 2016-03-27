//
//  RoomsNearbyViewController.swift
//  PollingApp
//
//  Created by Milton Leung on 2016-03-15.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class RoomsNearbyViewController: UIViewController {
    
    private var roomIDDictionary = [Room: RoomID]()
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
        container?.delegate = self
        container?.setRooms(rooms)
        
    }
    
    func getRooms(roomIDs: [String]) -> [String] {
        var temp_rooms = [String]()
        var temp_room_name:String
        for roomID in roomIDs {
            temp_room_name = ModelInterface.sharedInstance.getRoomName(roomID)
            temp_rooms.append(temp_room_name)
            roomIDDictionary[temp_room_name] = roomID
        }
        return temp_rooms
    }
}

extension RoomsNearbyViewController: RoomsNearbyViewContainerDelegate {
    func roomSelected(room: Room) {
        if let selectedRoomID = roomIDDictionary[room] {
            let roomSegue = ModelInterface.sharedInstance.goToRoom(selectedRoomID)
            print(selectedRoomID)
            performSegueWithIdentifier(roomSegue, sender: self)
        }
    }
}