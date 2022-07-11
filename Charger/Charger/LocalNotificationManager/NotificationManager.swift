//
//  NotificationManager.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit
// with this class we will handle Local Notifications
class NotificationManager {
  static var shared = NotificationManager() // create a singleton object
  
  /// Via this function we can ask for permission from user
  func requestPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in }
  }
}
