//
//  Filter.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation
// according to filter choices we will use it
struct FilterModel {
  var deviceTypes: [DeviceType]?
  var socketTypes: [SocketType]?
  var distance: Double?
  var services: [Services]?
}
