//
//  String+Extension.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-11.
//

import UIKit

extension String {
  
  /// with this string extension you can change the given text language according to app language
  func localizeString() -> String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
  
  func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
    let _font = font ?? UIFont.systemFont(ofSize: 20, weight: .regular)
    let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
    let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
    let range = (self as NSString).range(of: text)
    fullString.addAttributes(boldFontAttribute, range: range)
    return fullString
  }
  
  
}
