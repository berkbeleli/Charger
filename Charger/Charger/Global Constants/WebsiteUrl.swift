//
//  WebsiteURL.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation

// with this file we will reach all the websites we need our app
struct WebsiteUrl {
  static let loginUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login"
  static let logOutUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/logout/"
  static let citiesUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/provinces?userID="
  static let stationsUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations?userID="
  static let dateTimeUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations/"
  static let createAppointmentUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/make?userID="
  static let appointmentsUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/"
}
