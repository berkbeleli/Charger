//
//  Station.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

struct Station: Codable {
  var id: Int?
  var stationCode: String?
  var sockets: [SocketData]?
  var socketCount: Int?
  var occupiedSocketCount: Int?
  var distanceInKm: Double?
  var geoLocation: GeoLocation?
  var services: [String]?
  var stationName: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case stationCode
    case sockets
    case socketCount
    case occupiedSocketCount
    case distanceInKm = "distanceInKM"
    case geoLocation
    case services
    case stationName
  }
}

struct SocketData: Codable {
  var socketId: Int?
  var socketType: String?
  var chargeType: String?
  var power: Int?
  var powerUnit: String?
  var socketNumber: Int?
  
  enum CodingKeys: String, CodingKey {
    case socketId = "socketID"
    case socketType
    case chargeType
    case power
    case powerUnit
    case socketNumber
  }
}

struct GeoLocation: Codable {
  var longitude: Double?
  var latitude: Double?
  var province: String?
  var address: String?
}
// this structure will be used for viewing purpose
struct StationViewViewModel: Equatable {
  static func == (lhs: StationViewViewModel, rhs: StationViewViewModel) -> Bool {
    return lhs.stationId == rhs.stationId
  }
  var stationId: Int?
  var stationName: String?
  var availableSocket: String?
  var workingHours: String?
  var distance: String?
  var distanceFilter: Double?
  var socketTypes: [String]?
  var chargeTypes: [String]?
  var services: [String]?
  var imageType: UIImage?
}
