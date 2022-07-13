//
//  StationViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation


class StationViewModel{
  
  var onStationsChanged: (([StationViewViewModel]) -> ())? // stations completion handler
  var onStationsFiltered: (([StationViewViewModel]) -> ())? // stations completion handler
  var onStationsError: ((String) -> ())? // ERROR COMPLETION HANDLER
  
  var allStations: [StationViewViewModel]?
  var cityStations: [Station]?

  /// Fetch Stations according to user city selection from Api
  func fetchStations(cityName: String) {
    var stationsUrl = WebsiteUrl.stationsUrl + "\(User.user?.userId ?? -1)" // create custom url
    if LocationDatas.shared.locationlatitude != nil { // if user allowed the location permission we will add the locations to the URL
      stationsUrl += "&userLatitude=\(LocationDatas.shared.locationlatitude!)&userLongitude=\(LocationDatas.shared.locationlatitude!)"
    }
    
    WebServiceHelper.instance.getServiceData(url: stationsUrl, method: .get, header: UserToken.token) { [weak self] (returnedResponse: [Station]!, errorString: String?) in
      if errorString == nil {
        
        self?.cityStations = returnedResponse.filter{ $0.geoLocation?.province == cityName } // filter the stations that belongs to selected city
        
        self?.allStations = (self?.cityStations ?? []).map { // map the received station according to our usage Model
          StationViewViewModel.init(
            stationId: $0.id ?? 0,
            stationName: $0.stationName ?? "Unknown Station Name",
            availableSocket: "\(($0.socketCount ?? 0) - ($0.occupiedSocketCount ?? 0) ) / \($0.socketCount ?? 0)",
            workingHours: "24",
            distance: $0.distanceInKm == nil ? nil : "\($0.distanceInKm!.withOutCurrencySeperator ?? "0") km",
            services: $0.services ?? [])
        }
        
        if self?.allStations != nil { // we need to loop through our stations to insert their charge types and socket types into an array it will help us about filtering later on
          for index in 0..<(self?.allStations?.count ?? 0) {
            self?.allStations![index].chargeTypes = (self?.cityStations![index].sockets ?? []).map{ $0.chargeType! } // map charge types
            self?.allStations![index].socketTypes = (self?.cityStations![index].sockets ?? []).map{ $0.socketType! } // map socket types
                        
            if (self?.allStations![index].chargeTypes?.contains("AC") ?? false) && (self?.allStations![index].chargeTypes?.contains("DC") ?? false) { // set the image for the view cell
              self?.allStations![index].imageType = Themes.acDcImage
            }else if (self?.allStations![index].chargeTypes?.contains("AC") ?? false) {
              self?.allStations![index].imageType = Themes.acImage
            }else {
              self?.allStations![index].imageType = Themes.dcImage
            }
            
          }
        }
        self?.onStationsChanged?(self?.allStations ?? []) // call the closure to let the vc know station fetched
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onStationsError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
  
  func resetStations() {
    onStationsChanged?(allStations ?? [])
  }
  
  
  func filterTextValueEntered(_ value: String) {
    if value == "" { // if the filtered value is empty make the array default
      resetStations()
    }else {
      var filteredStations: [StationViewViewModel] = []
      if allStations != [] {
        filteredStations = allStations!.filter{ $0.stationName!.contains(value) }
      }
 
      onStationsFiltered?(filteredStations)
    }
    
    
  }
  
  
}

//MARK: - private func
private extension StationViewModel {
  func getModifiedChange(_ degree: Double) -> String {
    return String(format: "%.2f", degree)
  }
}