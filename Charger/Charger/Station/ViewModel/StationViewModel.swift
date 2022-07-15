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
  var onFiltersConverted: (([String]) -> ())? // filters value mapped into string values
  var onStationsError: ((String) -> ())? // ERROR COMPLETION HANDLER
  var allStations: [StationViewViewModel]?
  var filterStations: [StationViewViewModel]?
  var cityStations: [Station]?
  var filterValues: FilterModel?
  var filtersForDisplay: [String]?
  
  /// Fetch Stations according to user city selection from Api
  func fetchStations(cityName: String) {
    var stationsUrl = WebsiteUrl.stationsUrl + "\(User.user?.userId ?? -1)" // create custom url
    if LocationDatas.shared.locationlatitude != nil { // if user allowed the location permission we will add the locations to the URL
      stationsUrl += "&userLatitude=\(LocationDatas.shared.locationlatitude!)&userLongitude=\(LocationDatas.shared.locationlongitude!)"
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
            distanceFilter: $0.distanceInKm,
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
        
        if LocationDatas.shared.locationlatitude != nil && self?.allStations != [] { // if user allowed the location permission if so  sort the stations based on their distances
          self?.allStations = self?.allStations?.sorted { $0.distanceFilter ?? 0 < $1.distanceFilter ?? 0 }
        }
        
        self?.onStationsChanged?(self?.allStations ?? []) // call the closure to let the vc know station fetched
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onStationsError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
  /// request modified filter values
  func filterValuesRequest() -> FilterModel {
    return filterValues ?? .init(deviceTypes: [], socketTypes: [], distance: nil, services: [])
  }
  /// reset filter station values if we are on the filtered array send back that array
  func resetStations() {
    if (filtersForDisplay?.count ?? 0) > 0 {
      onStationsChanged?(filterStations ?? [])
    }else {
      onStationsChanged?(allStations ?? [])
    }
  }
  
  /// when custom text field entered a word call this func
  func filterTextValueEntered(_ value: String) {
    if value == "" { // if the filtered value is empty make the array default
      resetStations()
    }else if (filtersForDisplay?.count ?? 0) > 0 { // if we are in the filtered array
      var filteredStations: [StationViewViewModel] = []
      if filterStations != [] {
        filteredStations = filterStations!.filter{ $0.stationName!.lowercased().contains(value.lowercased()) }
      }
      onStationsFiltered?(filteredStations)
    }else { // if we are in the normal array
      var filteredStations: [StationViewViewModel] = []
      if allStations != [] {
        filteredStations = allStations!.filter{ $0.stationName!.lowercased().contains(value.lowercased()) }
      }
      onStationsFiltered?(filteredStations)
    }
  }
  /// This function checks if the filter value contains any data
  func checkIfTheFiltersEmpty(filterValues: FilterModel) -> Bool {
    self.filterValues = filterValues
    
    if (filterValues.deviceTypes?.count ?? 0) > 0 { // check the number of the elements
      return true
    }else if (filterValues.socketTypes?.count ?? 0) > 0 { // check the number of the elements
      return true
    }else if (filterValues.services?.count ?? 0) > 0 { // check the number of the elements
      return true
    }else if filterValues.distance != nil {
      return true
    }else {
      return false
    }
  }
  
  func convertReceivedFilters() {
    filtersForDisplay = []
    if !(filterValues?.deviceTypes!.isEmpty ?? true) {  // check if the array empty
      for value in filterValues!.deviceTypes! {
        filtersForDisplay?.append(value.rawValue)
      }
    }
    
    if !(filterValues?.socketTypes!.isEmpty ?? true) { // check if the array empty
      for value in filterValues!.socketTypes! {
        filtersForDisplay?.append(value.rawValue)
      }
    }
    
    if !(filterValues?.services!.isEmpty ?? true) { // check if the array empty
      for value in filterValues!.services! {
        filtersForDisplay?.append(value.rawValue)
      }
    }
    
    if filterValues?.distance != nil { // check if the distance empty
      filtersForDisplay?.append("\(filterValues?.distance?.withOutCurrencySeperator ?? "0") km")
    }
    onFiltersConverted?(filtersForDisplay ?? [])
    filteredStations() // call the filter function according to filter selections
  }
  
  func filteredStations() {
    var resultFilter: [StationViewViewModel] = []
    for filterItemIndex in 0..<(filtersForDisplay?.count ?? 0) {
      
      if filterItemIndex == 0 { // check if we are in the first index
        if let enumCase = DeviceType(rawValue: filtersForDisplay![0]) { //check if the first item device type filter
          resultFilter = allStations!.filter({ data in
            return data.chargeTypes!.contains(where: { $0 == filtersForDisplay![0]}) // check the item
          })
        }else if let enumCase = SocketType(rawValue: filtersForDisplay![0]) { //check if the first item socket type filter
          resultFilter = allStations!.filter({ data in
            return data.socketTypes!.contains(where: { $0 == filtersForDisplay![0]})// check the item
          })
        }else if let enumCase = Services(rawValue: filtersForDisplay![0]) { //check if the first item service type filter
          resultFilter = allStations!.filter({ data in
            return data.services!.contains(where: { $0 == filtersForDisplay![0]})// check the item
          })
        }else {
          resultFilter = allStations!.filter({ data in //check if the first item distance type filter
            let result = filtersForDisplay![0].filter("0123456789.".contains)
            return (data.distanceFilter ?? 0)! < Double(result.replacingOccurrences(of: ",", with: ".")) ?? 0
          })
        }
      } else { // after the first filtered item we will do the second according to first item
        
        if let enumCase = DeviceType(rawValue: filtersForDisplay![filterItemIndex]) {//check if the item device type filter
          resultFilter = resultFilter.filter({ data in
            return data.chargeTypes!.contains(where: { $0 == filtersForDisplay![filterItemIndex]})// check the item
          })
        }else if let enumCase = SocketType(rawValue:  filtersForDisplay![filterItemIndex]) { //check if the item socket type filter
          
          resultFilter = resultFilter.filter({ data in
            return data.socketTypes!.contains(where: { $0 == filtersForDisplay![filterItemIndex]})// check the item
          })
          
        }else if let enumCase = Services(rawValue:  filtersForDisplay![filterItemIndex]) { //check if the item service type filter
          
          resultFilter = resultFilter.filter({ data in
            return data.services!.contains(where: { $0 == filtersForDisplay![filterItemIndex]})// check the item
          })
          
        }else {
          resultFilter = resultFilter.filter({ data in
            let result = filtersForDisplay![filterItemIndex].filter("0123456789.".contains)
            return (data.distanceFilter ?? 0)! < Double(result.replacingOccurrences(of: ",", with: ".")) ?? 0
          })
        }
      }
      
    }
    
    if resultFilter == [] && filtersForDisplay?.count == 0 { // if all of the filters deleted get the first array
      filterStations = allStations
    }else {
      filterStations = resultFilter // if not get the result array
    }
    
    
    onStationsChanged?(filterStations ?? []) // return the result array to our vc
  }
  
  // remove the filter according to given raw value
  func removeFilter(filterName: String) {
    
    if let enumCase = DeviceType(rawValue: filterName) { // if the given raw value belongs to device type
      if (filterValues?.deviceTypes?.contains( enumCase )) ?? false {
        filterValues?.deviceTypes?.removeAll { $0 == enumCase }
      }
    }else if let enumCase = SocketType(rawValue: filterName) {// if the given raw value belongs to socket type
      if (filterValues?.socketTypes?.contains( enumCase )) ?? false {
        filterValues?.socketTypes?.removeAll { $0 == enumCase }
      }
    }else if let enumCase = Services(rawValue: filterName) { // if the given raw value belongs to service type
      if (filterValues?.services?.contains( enumCase )) ?? false {
        filterValues?.services?.removeAll { $0 == enumCase }
      }
    }else {
      filterValues?.distance = nil // if the given raw value belongs to distance type
    }
    convertReceivedFilters() // after removing the item reload the filter items
  }
}

//MARK: - private func
private extension StationViewModel {
  func getModifiedChange(_ degree: Double) -> String {
    return String(format: "%.2f", degree)
  }
}
