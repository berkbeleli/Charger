//
//  DateTimeViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import Foundation


class DateTimeViewModel{
  
  var onCitiesChanged: (([LetterCities]) -> ())? // cities completion handler
  var onCitiesFiltered: (([LetterCities]) -> ())? // cities completion handler
  var onCitiesError: ((String) -> ())? // ERROR COMPLETION HANDLER
  var allCityLetter: [LetterCities]?
  var allCities: [String]?
  /// Fetch Cities from Api
  func fetchCities() {
    let citiesUrl = WebsiteUrl.citiesUrl + "\(User.user?.userId ?? -1)" // create custom url
    
    WebServiceHelper.instance.getServiceData(url: citiesUrl, method: .get, header: UserToken.token) { [weak self] (returnedResponse: [String]!, errorString: String?) in
      if errorString == nil {
        self?.allCities = returnedResponse
        self?.allCityLetter = returnedResponse.map { // map the returned string array according to our needs to view it
          .init(city: $0, boldString: "")
        }
        self?.onCitiesChanged?(self?.allCityLetter ?? [])
      }else {
        // SHOW ERROR PAGE HERE!!!!
        self?.onCitiesError?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
  
}
