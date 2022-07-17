//
//  Date+Extension.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import Foundation

extension Date {
// using this extension we can get the difference between two date type
  static func -(recent: Date, previous: Date) -> (hour: Int?, minute: Int?, second: Int?) {
          let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
          let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
          let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
          return (hour: hour, minute: minute, second: second)
      }
}
