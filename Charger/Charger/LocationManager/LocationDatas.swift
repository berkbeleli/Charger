//
//  LocationDatas.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation

struct LocationDatas {
  static var shared = LocationDatas() // with this singleton object we can reach user location from anywhere of the app
  
  var locationlatitude: Double?
  var locationlongitude: Double?
}
