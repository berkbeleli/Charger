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
              socketId: "\($0.socketId!)",
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
        
        self?.onTimesChanged?(viewTimeDatas)
        self?.onViewsSocketsChanged?(viewSocketValues)
       
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onTimesError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
  
}
