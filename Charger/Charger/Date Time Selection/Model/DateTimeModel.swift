//
//  DateTimeModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import Foundation

struct SelectTimeStations: Codable {
  var stationId: Int?
  var stationCode: String?
  var sockets: [Socket]?
  var geoLocation: GeoLocation?
  var services: [String]?
  var stationName: String?
  
  enum CodingKeys: String, CodingKey {
    case stationId = "stationID"
    case stationCode
    case sockets
    case geoLocation
    case services
    case stationName
  }
}

struct Socket: Codable {
  var socketId: Int?
  var day: DaySocket?
  var socketType: String?
  var chargeType: String?
  var power: Int?
  var socketNumber: Int?
  var powerUnit: String?
  
  enum CodingKeys: String, CodingKey {
    case socketId = "socketID"
    case day
    case socketType
    case chargeType
    case power
    case socketNumber
    case powerUnit
  }
}

struct DaySocket: Codable {
  var id: Int?
  var date: String?
  var timeSlots: [TimeSlot]?
}

struct TimeSlot: Codable {
  var slot: String?
  var isOccupied: Bool?
}

// we will use next 4 four model for our view
struct SelectTimeViewModel {
  var stationId: Int?
  var stationCode: String?
  var address: String?
  var services: [String]?
  var sockets: [SocketView]?
}

struct SocketView {
  var socketId: String?
  var day: DaySocketView?
  var socketType: String?
  var chargeType: String?
  var power: String?
  var socketNumber: String?
  var powerUnit: String?
}

struct DaySocketView {
  var timeSlots: [TimeSlotView]?
}

struct TimeSlotView {
  var slot: String?
  var isOccupied: Bool?
  var isSocketSelected: Bool? = false
}
