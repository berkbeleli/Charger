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
  /// converts the user Selection date and time datas into date type
  func convertDate(dateData: String, timeData: String) -> Date {
    let dateString = "\(dateData) \(timeData)" // create a completed string date with given datas
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(secondsFromGMT:0)! // set the difference between timezone difference 0
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // set formatter type
    
    return dateFormatter.date(from: dateString)! // convert and return the date
  }
  
}
