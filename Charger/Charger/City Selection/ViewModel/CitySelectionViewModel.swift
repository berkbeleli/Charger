//
//  CitySelectionViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation

class CitySelectionViewModel{
  
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
  /// This function converts the given city name into english characters
  private func convertCityIntoEnglish(cityName: String) -> String {
    let cityNameLowerCased = cityName.lowercased()
    var tmpConvert = cityNameLowerCased.replacingOccurrences(of: "ı", with: "i") // convert
    tmpConvert = cityNameLowerCased.replacingOccurrences(of: "ğ", with: "g")// convert
    tmpConvert = cityNameLowerCased.replacingOccurrences(of: "ç", with: "c")// convert
    tmpConvert = cityNameLowerCased.replacingOccurrences(of: "ş", with: "s")// convert
    return tmpConvert
  }
  /// Set Citites default
  func resetCities() {
    onCitiesChanged?(allCityLetter ?? [])
  }
  
  func filterTextValueEntered(_ value: String) {
    if value == "" { // if the filtered value is empty make the array default
      resetCities()
    } else {
      var filteredCityLetter: [LetterCities]? = [] // before searching make our array empty so we can fit it
      
      if let allCities = allCities{ // check if there is any item in the array
        for index in 0..<(allCities.count) { // loop over all cities
          
          if allCities[index].lowercased().folding(options: .diacriticInsensitive, locale: .current).contains((value.lowercased())) || allCities[index].lowercased().contains((value.lowercased())) { // check if the current index contains the entered value
            
            let foundIndex = allCities[index].lowercased().folding(options: .diacriticInsensitive, locale: .current).index(findString: (value.lowercased())) // find the place of the found value
            let name = allCities[index].map { String($0) } // convert string into string array
            var boldString = "" // empty bold string first
            for index in (foundIndex..<(value.count + foundIndex)) {
              boldString += name[index] // append letters to our bold string
            }
            
            filteredCityLetter!.append(LetterCities(city: allCities[index], boldString: boldString)) // append found value to our array
            
          } else if convertCityIntoEnglish(cityName: allCities[index]).folding(options: .diacriticInsensitive, locale: .current).contains((value.lowercased())) {// check if the current index contains the entered value
            
            let foundIndex = allCities[index].lowercased().folding(options: .diacriticInsensitive, locale: .current).index(findString: (value.lowercased()))// find the place of the found value
            let name = allCities[index].map { String($0) }// convert string into string array
            var boldString = ""// empty bold string first
            for index in (foundIndex..<(value.count + foundIndex)) {
              boldString += name[index]// append letters to our bold string
            }
            
            filteredCityLetter!.append(LetterCities(city: allCities[index], boldString: boldString))// append found value to our array
          }
        }
      }
      onCitiesFiltered?(filteredCityLetter ?? []) // call filtered closure
    }
  }
}
