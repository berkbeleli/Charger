//
//  AppConstants.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit

struct AppConstants {
  // receive device ID
  static let deviceUDID: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
  // this will be used to displaay first 7 characters of the ID
  static let deviceUDDisplay: String = String(UIDevice.current.identifierForVendor?.uuidString.prefix(7) ?? "")
}
