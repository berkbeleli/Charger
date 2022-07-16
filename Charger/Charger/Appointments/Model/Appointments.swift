//
//  Appointments.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

struct Appointment: Codable {
  var appointmentId: Int?
  var date: String?
  var time: String?
  var socketId: Int?
  var station: StationAppointment?
  var stationName: String?
  var hasPassed: Bool?
 
  enum CodingKeys: String, CodingKey {
    case appointmentId = "appointmentID"
    case date
    case time
    case socketId = "socketID"
    case station
    case stationName
    case hasPassed
  }
  
}

struct StationAppointment: Codable {
  var id: Int?
  var sockets: [SocketAppointment]?
}

struct SocketAppointment: Codable {
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

// we will use next 3 model for our view

struct AppointmentViewViewModel {
  var appointmentId: String?
  var date: String?
  var time: String?
  var showingTime: String?
  var showAlertTime: String?
  var stationId: String?
  var socketId: String?
  var socket: SocketAppointment?
  var outpower: String?
  var stationName: String?
  var hasPassed: Bool?
  var notificationTime: String?
  var imageType: UIImage?
}

