//
//  CitySelectionViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation

class CitySelectionViewModel{
  
  var onCitiesChanged: (([String]) -> ())? // cities completion handler
  var onCitiesError: ((String) -> ())? // ERROR COMPLETION HANDLER
  
  /// Fetch Cities from Api
  func fetchCities() {
    
    let citiesUrl = WebsiteUrl.citiesUrl + "\(User.user?.userId ?? -1)"
    
    WebServiceHelper.instance.getServiceData(url: citiesUrl, method: .get, header: UserToken.token) { [weak self] (returnedResponse: [String]!, errorString: String?) in
      if errorString == nil {
        self?.onCitiesChanged?(returnedResponse)
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onCitiesError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
}
