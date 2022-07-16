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
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in}
  }
    /// Creates a notification
  func createAppointmentNotification(date: String, time: String, minutesAgo: Int ,identifier: String, title: String, body: String, completion: @escaping ((String) -> ())) {
    // Initialize User Notification Center Object
    let center = UNUserNotificationCenter.current()
    
    let dateString = "\(date) \(time)"
    // The content of the Notification
    let content = UNMutableNotificationContent()
    content.title = title // set notification's datas
    content.body = body
    content.sound = .default
    
    let formatter = DateFormatter() // create a date formatter
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    guard var Notificationdate = formatter.date(from: dateString) else {
      return
    }
    Notificationdate.addTimeInterval(TimeInterval(Double(-minutesAgo) * 60.0)) // get the specified minutes ago date value
    let todayDate = DateHandler.shared.getTodayDate() // get today date
    
    formatter.dateFormat = "yyyy" // get year data
    let year = formatter.string(from: Notificationdate) // get year data
    formatter.dateFormat = "MM" // get month data
    let month = formatter.string(from: Notificationdate) // get month data
    formatter.dateFormat = "dd" // get day data
    let day = formatter.string(from: Notificationdate)  // get day data
    formatter.dateFormat = "HH"  // get hour data
    let hour = formatter.string(from: Notificationdate)  // get hour data
    formatter.dateFormat = "mm" // get minute data
    let minute = formatter.string(from: Notificationdate) // get minute data
    
    let NotificationDateBeforeMinutes = DateHandler.shared.convertDate(dateData: "\(year)-\(month)-\(day)", timeData: "\(hour):\(minute)")
    
    let difference = NotificationDateBeforeMinutes - todayDate // get the time difference
    if (difference.minute ?? 0) < 1 { // if it is less than 1 minute
      completion("NOTIFICATION OLDER DATE")
    }else { // if there is still time for showing notification
      // The selected time to notify the user we convert them into DateComponents type so we can set up a notification
      var dateComponents = DateComponents()
      dateComponents.calendar = Calendar.current
      dateComponents.hour = Int(hour)
      dateComponents.minute = Int(minute)
      dateComponents.month = Int(month)
      dateComponents.year = Int(year)
      dateComponents.day = Int(day)
      
      // The time/repeat trigger
      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
      
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
          // Initializing the Notification Request object to add to the Notification Center
          let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger) // create with given idendifer a new notification
          // Adding the notification to the center
          center.add(request)
          completion("NOTIFICATION SET")
        } else if let error = error {
          print(error.localizedDescription) // problem occured, prints error message
        }else {
          completion("NOTIFICATION NOT ALLOWED")
        }
      }
    }
  }
  
  /// This function remove the notification that has the given identifier
  func removeNotification(identifier: String) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: [identifier])
  }
  
}
