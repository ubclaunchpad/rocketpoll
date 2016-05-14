//
//  RoomModelProtocol.swift
//  PollingApp
//
//  Created by Jon on 2016-03-06.
//  Copyright © 2016 Jon Mercer. All rights reserved.
//

import Foundation

protocol RoomModelProtocol {
  
  func submitRoomName(roomName: String) -> SegueName
  func getCurrentRoomID() -> RoomID
  func getRoomName(roomId: RoomID) -> String
  func goToRoom(roomId: RoomID) -> SegueName
  func getRoomsNeaby() -> [RoomID]
  
}
