//
//  CoreDataHandler.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import UIKit
import CoreData

struct CoreDataHandler {
  static var shared = CoreDataHandler() // creates a singleton object
  var notifications: [NSManagedObject] = []
  /// This function saves the received notification values
  mutating func saveNotificationData(appointmentDate: String, appointmentTime: String, notificationTimer: String, notificationUniqueId: String, socketId: String, stationId: String) {
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    // 1 get the context
    let managedContext = appDelegate.persistentContainer.viewContext
    // 2 get the core data object
    let entity = NSEntityDescription.entity(forEntityName: "AppointmentsCore",
                                 in: managedContext)!
    
    let notification = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3 set the row values according to received values
    notification.setValue(appointmentDate, forKeyPath: "appointmentDate")
    notification.setValue(appointmentTime, forKeyPath: "appointmentTime")
    notification.setValue(notificationTimer, forKeyPath: "notificationTimer")
    notification.setValue(notificationUniqueId, forKeyPath: "notificationUniqueId")
    notification.setValue(socketId, forKeyPath: "socketId")
    notification.setValue(stationId, forKeyPath: "stationId")
    
    // 4 save the values
    do {
      try managedContext.save()
      notifications.append(notification)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  /// Get the notification value according to choice
  mutating func catchAppoinmentNotificationData(returnType: String, appointmentDate: String, appointmentTime: String, socketId: String, stationId: String) -> String {
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return "could not catch"
      }
    // 1 get the context
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
    // 2 get the core data object
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "AppointmentsCore")
      
    // 3 get the values
      do {
        self.notifications = try managedContext.fetch(fetchRequest)
        
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    
    // filter the values according to the user choices
    let resultNotification = notifications.filter {
      ($0.value(forKey: "appointmentDate") as! String) == appointmentDate &&
      ($0.value(forKey: "appointmentTime") as! String) == appointmentTime &&
      ($0.value(forKey: "socketId") as! String) == socketId &&
      ($0.value(forKey: "stationId") as! String) == stationId
    }
    if resultNotification.count > 0 { // check if there is any notification for that value
      if returnType == "notificationTime" { // if user asks for notification timer value we will return it
        return (resultNotification[0].value(forKey: "notificationTimer") as? String)!
      }else if returnType == "identifier" { // if the notification identifier requested
        return (resultNotification[0].value(forKey: "notificationUniqueId") as? String)!
      }
    }
    return ""
  }
  
}
