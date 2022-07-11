//
//  String+Extension.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-11.
//

import Foundation

extension String {
  
  /// with this string extension you can change the given text language according to app language
  func localizeString() -> String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
  
}
