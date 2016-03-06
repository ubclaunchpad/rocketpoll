//
//  RoomNameExtentsion.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import Foundation

extension ModelInterface: RoomModelProtocol {
  
  /**
   Join a room or create it if it doesn't exist
   - Parameter roomName: An existing or new room's name
   */
  func submitRoomName(roomName: String) -> SegueName {
    return Segues.toMainApp
  }
  
  func getCurrentRoomID() -> RoomID {
    return "R1"
  }
  
  func getRoomName(roomId: RoomID) -> String {
    return "ARoomName"
  }
  
  func goToRoom(roomId: RoomID) -> SegueName {
    return Segues.toMainApp
  }
  
  func getRoomsNeaby() -> [RoomID] {
    return ["R1","R2"]
  }
  
}
