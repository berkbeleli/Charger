//
//  UITextField+Extension.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit

extension UITextField {
  ///With this extension function you can create a line under the given textField
  func useUnderline() -> Void {
    let border = CALayer()
    let borderWidth = CGFloat(1.0) // Border Width
    border.borderColor = Themes.colorGrayScale.cgColor // Border coclor
    border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}
