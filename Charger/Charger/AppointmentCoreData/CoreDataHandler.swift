//
//  CoreDataHandler.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import UIKit
import CoreData

struct CoreDataHandler {
  static var shared = CoreDataHandler()
  var notifications: [NSManagedObject] = []
  
  mutating func saveNotificationData(appointmentDate: String, appointmentTime: String, notificationTimer: String, notificationUniqueId: String, socketId: String, stationId: String) {
    
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    // 1
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    // 2
    let entity =
      NSEntityDescription.entity(forEntityName: "Appointment",
                                 in: managedContext)!
    
    let notification = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3
    notification.setValue(appointmentDate, forKeyPath: "appointmentDate")
    notification.setValue(appointmentTime, forKeyPath: "appointmentTime")
    notification.setValue(notificationTimer, forKeyPath: "notificationTimer")
    notification.setValue(notificationUniqueId, forKeyPath: "notificationUniqueId")
    notification.setValue(socketId, forKeyPath: "socketId")
    notification.setValue(stationId, forKeyPath: "stationId")
    
    // 4
    do {
      try managedContext.save()
      notifications.append(notification)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
}
