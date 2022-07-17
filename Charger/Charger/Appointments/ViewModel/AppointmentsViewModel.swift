//
//  AppointmentsViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import Foundation
class AppointmentsViewModel{
  var onAppointmentsChanged: (([AppointmentViewViewModel], [AppointmentViewViewModel]) -> ())? // appointments completion handler
  var onAppointmentsError: ((String) -> ())? // ERROR COMPLETION HANDLER
  var allAppointments: [AppointmentViewViewModel]?
  var currentAppointments: [AppointmentViewViewModel]? // holds curront appointments
  var pastAppointments: [AppointmentViewViewModel]? // holds past appointments
  /// Fetch Appointments
  func fetchAppointments() {
    var appointmentsUrl = WebsiteUrl.appointmentsUrl + "\(User.user?.userId ?? -1)" // create custom url
    if LocationDatas.shared.locationlatitude != nil { // if user allowed the location permission we will add the locations to the URL
      appointmentsUrl += "?userLatitude=\(LocationDatas.shared.locationlatitude!)&userLongitude=\(LocationDatas.shared.locationlongitude!)"
    }
    
    WebServiceHelper.instance.getServiceData(url: appointmentsUrl, method: .get, header: UserToken.token) { [weak self] (returnedResponse: [Appointment]!, errorString: String?) in
      if errorString == nil {
        
        self?.allAppointments = (returnedResponse ?? []).map {
                AppointmentViewViewModel.init(
                  appointmentId: "\($0.appointmentId ?? 0)",
                  date: $0.date,
                  time: $0.time,
                  stationId: "\($0.station?.id ?? 0)",
                  socketId: "\($0.socketId ?? 0)",
                  stationName: $0.stationName,
                  hasPassed: $0.hasPassed,
                  notificationTime: "") // we will get it if the notification allowed
              }
        
        if self?.allAppointments != nil { // we need to loop through our stations to insert their charge types and notification times
          for index in 0..<(self?.allAppointments?.count ?? 0) {
            let socketId = Int((self?.allAppointments![index].socketId)!)
            self?.allAppointments![index].socket = (returnedResponse![index].station?.sockets ?? []).filter{
              $0.socketId == socketId
            }.first
            
            if self?.allAppointments![index].hasPassed == false {
            let resultTime = CoreDataHandler.shared.catchAppoinmentNotificationData(
              returnType: "notificationTime",
              appointmentDate:  self?.allAppointments![index].date ?? "",
              appointmentTime: self?.allAppointments![index].time ?? "",
              socketId: self?.allAppointments![index].socketId ?? "",
              stationId: self?.allAppointments![index].stationId! ?? "") + "m" // m letter for localization
              resultTime == "m" ? (self?.allAppointments![index].notificationTime = "") : (self?.allAppointments![index].notificationTime = resultTime) // check if there is not any notification remove the notificationTime label
            }
            
            self?.allAppointments![index].outpower = "\(self?.allAppointments![index].socket?.power ?? 0) \(self?.allAppointments![index].socket?.powerUnit ?? "kVa")" // create outpower label
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from:  self?.allAppointments![index].date ?? "2022-01-01")
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "dd MMM yyyy"
            
            dateFormatter.dateFormat = "dd M yyyy" // these two for the popupdate
            dateFormatter.dateStyle = .long
            
            self?.allAppointments![index].showAlertTime = dateFormatter.string(from: date!) // alert date
            
            
            self?.allAppointments![index].showingTime = dateFormatter2.string(from: date!) + ", " +  (self?.allAppointments![index].time ?? " ")! // create showing time type
            
            
            let chargeTypes = (returnedResponse![index].station?.sockets ?? []).map{
              $0.chargeType!
            }
            if (chargeTypes.contains("AC") ) && (chargeTypes.contains("DC") ) { // set the image for the view cell
              self?.allAppointments![index].imageType = Themes.acDcImage
            }else if (chargeTypes.contains("AC") ) {
              self?.allAppointments![index].imageType = Themes.acImage
            }else {
              self?.allAppointments![index].imageType = Themes.dcImage
            }
            
          }
        }
        
        self?.currentAppointments = self?.allAppointments?.filter{ $0.hasPassed == false } // set current appointments
        self?.pastAppointments = self?.allAppointments?.filter{ $0.hasPassed == true } // seet past appointments
        
        // call the closure to let the vc know appointments fetched
        self?.onAppointmentsChanged?((self?.currentAppointments ?? []),(self?.pastAppointments ?? []))
        
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onAppointmentsError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
  
  
  //MARK: - Delete Appointment
  func deleteAppointment(appointmentID: String){
    let appointmentDeletionUrl = WebsiteUrl.appointmentDeleteUrl + appointmentID + "?userID=\(User.user?.userId ?? -1)" // create custom url

    // cal generic api handler func
    WebServiceHelper.instance.getServiceData(url: appointmentDeletionUrl, method: .delete, header: UserToken.token) { [weak self] (returnedResponse: String!, errorString: String?) in
      if errorString == nil {
        let appointmentDatas = self?.allAppointments?.filter { $0.appointmentId == appointmentID }.first
        if appointmentDatas?.notificationTime != "" { // if there is any notification set we will delete that notification
          self?.deleteNotification(appointmentDatas: appointmentDatas!)
        }
        self?.fetchAppointments() // after deletion of the appointment call the fetch appointment func again
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onAppointmentsError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
  // remove deleted appointment Notification Value
  func deleteNotification(appointmentDatas: AppointmentViewViewModel) {
    let notificationIdentifier = CoreDataHandler.shared.catchAppoinmentNotificationData(
      returnType: "identifier",
      appointmentDate: (appointmentDatas.date ?? "2022-01-01"),
      appointmentTime: (appointmentDatas.time ?? "00:00"),
      socketId: (appointmentDatas.socketId ?? ""),
      stationId: (appointmentDatas.stationId ?? ""))
    NotificationManager.shared.removeNotification(identifier: notificationIdentifier) // according to the received notification identifier we will delete the notification
  }
  /// Checks the number of the current appointment higher than 10 
  func shouldNavigateNextPage() -> Bool {
    if (currentAppointments?.count ?? 0) > 10 {
      return false
    }else {
      return true
    }
  }
  
}


