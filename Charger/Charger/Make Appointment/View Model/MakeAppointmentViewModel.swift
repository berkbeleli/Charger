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
  var getNotified: Bool? = false // it will inddicate if we are going to show notification
  var notificationTime: String? = "5m" // default notification Time
  private var appointmentValues: AppointmentDatas?
  /// Fetch Times from Api
  func createAppointment() {
    var createAppointmentUrl = WebsiteUrl.createAppointmentUrl + "\(User.user?.userId ?? -1)" // create custom url
    if LocationDatas.shared.locationlatitude != nil { // if user allowed the location permission we will add the locations to the URL
      createAppointmentUrl += "&userLatitude=\(LocationDatas.shared.locationlatitude!)&userLongitude=\(LocationDatas.shared.locationlongitude!)"
    }
    
    let parameter: [String: Any] = ["stationID": appointmentValues?.stationID ?? 0,"socketID": appointmentValues?.socketNumber ?? 0, "timeSlot": appointmentValues?.time ?? "0", "appointmentDate": "\(appointmentValues?.dateData ?? "")"]
    
    WebServiceHelper.instance.getServiceData(url: createAppointmentUrl, method: .get, parameters: parameter ,header: UserToken.token) { [weak self] (returnedResponse: Appointment!, errorString: String?) in
      if errorString == nil {
        
        self?.onAppointmentCreated?("Created Appointment")
   
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onAppointmentError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
}
