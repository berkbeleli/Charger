//
//  StationViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation


class StationViewModel{
  
  var onStationsChanged: (([LetterCities]) -> ())? // cities completion handler
  var onStationsFiltered: (([LetterCities]) -> ())? // cities completion handler
  var onStationsError: ((String) -> ())? // ERROR COMPLETION HANDLER

  /// Fetch Cities from Api
  func fetchStations() {


  }
}
