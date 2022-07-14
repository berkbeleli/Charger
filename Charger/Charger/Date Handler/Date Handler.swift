//
//  Date Handler.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import Foundation

struct DateHandler {
  
  static var shared = DateHandler()
  /// return current Date
  func getTodayDate() -> Date{
    let currentDate = Date()
     
    // 1) Create a DateFormatter() object.
    let format = DateFormatter()
    // 2) Set the current timezone to .current, or America/Chicago.
    format.timeZone = .current
    // 3) Set the format of the altered date.
    format.dateFormat = "yyyy-MM-dd HH:mm"
    // 4) Set the current date, altered by timezone.
    let dateString = format.string(from: currentDate)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(secondsFromGMT:0)!
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    return dateFormatter.date(from: dateString)!
  }
  
}
