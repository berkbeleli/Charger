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
  
  mutating func catchAppoinmentNotificationData(returnType: String, appointmentDate: String, appointmentTime: String, socketId: String, stationId: String) -> String {
    //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return "could not catch"
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "AppointmentsCore")
      
      //3
      do {
        self.notifications = try managedContext.fetch(fetchRequest)
        
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    if returnType == "notificationTime" {
      let resultNotification = notifications.filter {
        ($0.value(forKey: "appointmentDate") as! String) == appointmentDate &&
        ($0.value(forKey: "appointmentTime") as! String) == appointmentTime &&
        ($0.value(forKey: "socketId") as! String) == socketId &&
        ($0.value(forKey: "stationId") as! String) == stationId

      }
      return (resultNotification[0].value(forKey: "notificationTimer") as? String)!
    }else if returnType == "identifier" {
      let resultNotification = notifications.filter {
        ($0.value(forKey: "appointmentDate") as! String) == appointmentDate &&
        ($0.value(forKey: "appointmentTime") as! String) == appointmentTime &&
        ($0.value(forKey: "socketId") as! String) == socketId &&
        ($0.value(forKey: "stationId") as! String) == stationId
      }
      return (resultNotification[0].value(forKey: "notificationUniqueId") as? String)!
    }
    return ""
  }
  
}
