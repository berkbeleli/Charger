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
  var currentAppointments: [AppointmentViewViewModel]?
  var pastAppointments: [AppointmentViewViewModel]?
  
  /// Fetch Stations according to user city selection from Api
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
                  socketId: "\($0.socketId ?? 0)",
                  stationName: $0.stationName,
                  hasPassed: $0.hasPassed,
                  notificationTime: "5 minutes ago") // we will get it iff the notification allowed
              }
        
        
        if self?.allAppointments != nil { // we need to loop through our stations to insert their charge types and socket types into an array it will help us about filtering later on
          for index in 0..<(self?.allAppointments?.count ?? 0) {
            var socketId = Int((self?.allAppointments![index].socketId)!)
            self?.allAppointments![index].socket = (returnedResponse![index].station?.sockets ?? []).filter{
              $0.socketId == socketId
            }.first
            
            var chargeTypes = (returnedResponse![index].station?.sockets ?? []).map{
              $0.chargeType!
            }
            
            self?.allAppointments![index].outpower = "\(self?.allAppointments![index].socket?.power ?? 0) \(self?.allAppointments![index].socket?.powerUnit ?? "kVa")"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from:  self?.allAppointments![index].date ?? "2022-01-01")
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "dd MMM yyyy"
            
            self?.allAppointments![index].showingTime = dateFormatter2.string(from: date!) + ", " +  (self?.allAppointments![index].time ?? " ")!
            
            if (chargeTypes.contains("AC") ?? false) && (chargeTypes.contains("DC") ?? false) { // set the image for the view cell
              self?.allAppointments![index].imageType = Themes.acDcImage
            }else if (chargeTypes.contains("AC") ?? false) {
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
}


