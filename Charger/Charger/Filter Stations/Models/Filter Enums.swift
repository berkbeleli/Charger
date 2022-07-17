//
//  Filter Enums.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation
 // this enums raw values contains the api values
enum DeviceType: String {
  case AC = "AC", DC = "DC"
}

enum SocketType: String {
  case Type2 = "Type 2", CSC = "CSC", CHAdeMO = "CHAdeMO"
}

enum Services: String {
  case CarPark = "Otopark", Buffet = "Büfe", Wifi = "Wi-Fi"
}
