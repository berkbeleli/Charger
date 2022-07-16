//
//  MakeAppointmentViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import Foundation

class MakeAppointmentViewModel{
  
  var onAppointmentCreated: ((String) -> ())?
  var onAppointmentError: ((String) -> ())? // ERROR COMPLETION HANDLER
  var onNotificationError: ((String) -> ())?
  var getNotified: Bool? = false // it will inddicate if we are going to show notification
  var notificationTime: String? = "5m" // default notification Time
  var stationName: String? = ""
  var appointmentValues: AppointmentDatas?
  /// Fetch Times from Api
  func requestAppointment() {
    
    
    var shouldAppoint: Bool = true // it will check before making appointment if there is any error like notification timers
    
    if getNotified ?? false { // check if the user asks for notification
      
      let titleValue = String(format: NSLocalizedString("station: %@ timeleft: %@", comment: ""), stationName as! NSString, notificationTime?.localizeString() as! NSString) // create a localized title Value for our notification
      
      let minutesAgo = Int(notificationTime!.filter("0123456789".contains)) // turn the notification Time into filtered number

      var identifier = UUID().uuidString
      NotificationManager.shared.createAppointmentNotification( // send the required variables to the func to create notification
        date: appointmentValues?.dateData ?? "2022-01-01",
        time: appointmentValues?.time ?? "00:00",
        minutesAgo: minutesAgo!,
        identifier: identifier,
        title: "upcomingAppointment".localizeString(),
        body: titleValue) {[weak self] result in
          
          if result == "NOTIFICATION SET" {
            DispatchQueue.main.async { // we need tto use our core data model in the main branch
              CoreDataHandler.shared.saveNotificationData(
                appointmentDate: (self?.appointmentValues?.dateData)!,
                appointmentTime: (self?.appointmentValues?.time)!,
                notificationTimer: "\(minutesAgo!)",
                notificationUniqueId: identifier,
                socketId: "\(self?.appointmentValues?.socketNumber ?? 0)",
                stationId: "\(self?.appointmentValues?.stationID ?? 0)") // save the set notification values inside our core data
            }
    
            self?.createAppointment() // if the notification set call the createAppointment func
          }else {
            self?.onNotificationError?(result)
          }
        }
    }else {
      createAppointment() // if user does not want to receive notifications
    }
    
  }
  /// creates an appointment
  private func createAppointment() {
    var createAppointmentUrl = WebsiteUrl.createAppointmentUrl + "\(User.user?.userId ?? -1)" // create custom url
    if LocationDatas.shared.locationlatitude != nil { // if user allowed the location permission we will add the locations to the URL
      createAppointmentUrl += "&userLatitude=\(LocationDatas.shared.locationlatitude!)&userLongitude=\(LocationDatas.shared.locationlongitude!)"
    }
    // set the required parameters
    let parameter: [String: Any] = ["stationID": appointmentValues?.stationID ?? 0, "socketID": appointmentValues?.socketNumber ?? 0, "timeSlot": appointmentValues?.time ?? "0", "appointmentDate": "\(appointmentValues?.dateData ?? "")"]
    // cal generic api handler func
    WebServiceHelper.instance.getServiceData(url: createAppointmentUrl, method: .post, parameters: parameter ,header: UserToken.token) { [weak self] (returnedResponse: Appointment!, errorString: String?) in
      if errorString == nil {
        self?.onAppointmentCreated?("Created Appointment")
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onAppointmentError?(errorString ?? "UNKNOWN ERROR")
      }
    }
    
  }
}
