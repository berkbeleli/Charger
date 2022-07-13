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
  /// with this string extension we can give the string that we want to make bold
  ///  ```
  /// let stringText = "Say Hello"
  /// stringText.withBoldText(text: "Hell")
  /// ```
  /// If you don't give a custom font this function will use the system font
  func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
    let _font = font ?? UIFont.systemFont(ofSize: 20, weight: .regular)
    let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
    let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
    let range = (self as NSString).range(of: text)
    fullString.addAttributes(boldFontAttribute, range: range)
    return fullString
  }
  
  /// With this extension we can check our entered email is valid before requesting from api
  func isValidEmail() -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: self)
  }
  
  /// With this extension you can find the starting index  of the given string in the self string
  func index(findString: String) -> Int {
    if let range: Range<String.Index> = self.range(of: findString) {
        let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
        return index
    }
    else {
        print("substring not found")
    }
   return 0
  }
}
