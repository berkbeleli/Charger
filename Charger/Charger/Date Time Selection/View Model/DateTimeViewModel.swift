//
//  DateTimeViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import Foundation


class DateTimeViewModel{
  
  var onTimesChanged: ((SelectTimeViewModel) -> ())? // times completion handler
  var onViewsSocketsChanged: (([String]) -> ())?
  var onTimesError: ((String) -> ())? // ERROR COMPLETION HANDLER
  var numberOfSockets: Int?
  var dateData: String? // date that will be used in api calls
  var dateView: String? // date that is being shown to the user
  var distance: String? // distance to the
  var appointmentSelectedTime: String? = ""
  var appointmentDatas: AppointmentDatas? = AppointmentDatas()
  /// Fetch Times from Api
  func fetchTimes(stationId: String, date: String) {
    let timesUrl = WebsiteUrl.dateTimeUrl + "\(stationId)" + "?userID=\(User.user?.userId ?? 0)" + "&date=\(date)" // create custom url
    
    WebServiceHelper.instance.getServiceData(url: timesUrl, method: .get, header: UserToken.token) { [weak self] (returnedResponse: SelectTimeStations!, errorString: String?) in
      if errorString == nil {
        // map the received response according to our usage
        let viewTimeDatas = SelectTimeViewModel(
          stationId: returnedResponse.stationId,
          stationCode: returnedResponse.stationCode,
          address: returnedResponse.geoLocation?.address,
          services: returnedResponse.services,
          sockets: (returnedResponse.sockets ?? []).map{
            SocketView(
              socketId: $0.socketId!,
              day: DaySocketView(
                timeSlots: ($0.day?.timeSlots ?? []).map {
                  TimeSlotView(
                    slot: $0.slot,
                    isOccupied: $0.isOccupied)
                }),
              socketType: $0.socketType,
              chargeType: $0.chargeType,
              power: "\($0.power!)",
              socketNumber: "\($0.socketNumber)",
              powerUnit: $0.powerUnit)
          })
        // map the socket type Header label's values
        var viewSocketValues = (viewTimeDatas.sockets ?? []).map {
          $0.chargeType! + " • " + $0.socketType!
        }
        self?.numberOfSockets = viewSocketValues.count // set the number of the socket's count
        self?.onTimesChanged?(viewTimeDatas)
        self?.onViewsSocketsChanged?(viewSocketValues) // we will set the sockettype's label's with this
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onTimesError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
  /// Returns the Number of the sockets in a specific station
  func getNumberOfSockets() -> Int {
    numberOfSockets ?? 1
  }
  /// set date and distance Values
  func setDateAndDistanceValues(date: String, dateView: String, distance: String) {
    self.dateData = date
    self.dateView = dateView
    self.distance = distance
  }
  /// Creates Appointment Datas and returns them
  func createAppointmentDatas(allTimes: SelectTimeViewModel, tableNumber: Int, selectedRow: Int) {
    appointmentDatas = AppointmentDatas(
      address: allTimes.address,
      workingHours: "24",
      distance: distance == "-1" ? nil : distance, // check if the distance value exists
      stationCode: allTimes.stationCode,
      services: allTimes.services,
      stationID: allTimes.stationId,
      socketNumber: allTimes.sockets![tableNumber].socketId,
      deviceType: allTimes.sockets![tableNumber].chargeType,
      socketType: allTimes.sockets![tableNumber].socketType,
      outsorcepower: "\(allTimes.sockets![tableNumber].power ?? "0") \(allTimes.sockets![tableNumber].powerUnit ?? "kw")",
      dateView: dateView,
      dateData: dateData,
      time: allTimes.sockets![tableNumber].day?.timeSlots![selectedRow].slot,
      appointmentDuration: "1")
    appointmentSelectedTime = allTimes.sockets![tableNumber].day?.timeSlots![selectedRow].slot
  }
  
  func requestAppointmentDatas() -> AppointmentDatas {
    appointmentDatas!
  }
  /// checks if the selected date and time is past than the curentDate and Time
  func isDatePast() -> Bool {
    let selectedDate = DateHandler.shared.convertDate(dateData: dateData!, timeData: appointmentSelectedTime!)
    let todayDate = DateHandler.shared.getTodayDate() // get today date
    let difference = selectedDate - todayDate // get difference between today and selected date
    if difference.minute! < 0 {
      return true
    }else {
      return false
    }
  }
}
