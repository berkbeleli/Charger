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
  
  /// This function changes the image of the left side of the given text field
  ///
  ///  ```
  /// @IBOutlet weak var usernameTextField: UITextField!
  /// usernameTextField.setIcon(UIImage(named: "user")!)
  /// ```
  func setIcon(_ image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20)) // creates an icon view for  the left side of the textfield
    iconView.image = image
    iconView.tintColor = Themes.colorGrayScale
    
    let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30)) // creates a container for created icon
    iconContainerView.addSubview(iconView) // add created icon to our container
    leftView = iconContainerView // sets the left side of the textfield our created container
    leftViewMode = .always // sets the left side of  the textfield always visible
  }  
}
