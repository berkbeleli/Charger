//
//  Double+Extension.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation

extension Double {
  /// with this Function we can put a seperetorr , if the number is big
  var withOutCurrencySeperator : String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.currencySymbol = ""
    let newDistance = currencyFormatter.string(from: self as NSNumber)
    return newDistance ?? "0"
  }
}
