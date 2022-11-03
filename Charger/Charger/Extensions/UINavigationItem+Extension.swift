//
//  UINavigationItem+Extension.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import UIKit
extension UINavigationItem {
  /// This extension function  creates a navbar title with 2 titles
  func setSubTitle(_ title: String, subtitle: String) {
//    let textColor = Themes.colorSolidWhite
//    // title label types
//    let titleLabel = UILabel()
//    titleLabel.text = title
//    titleLabel.font = Themes.fontBoldStationSubValues
//    titleLabel.textColor = textColor
//    // subtitle label types
//    let subtitleLabel = UILabel()
//    subtitleLabel.text = subtitle
//    subtitleLabel.font = Themes.fontRegular
//    subtitleLabel.textColor = textColor.withAlphaComponent(0.75)
//    // create with these 2 labels a stacck view
//    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
//    stackView.distribution = .equalCentering
//    stackView.alignment = .center
//    stackView.axis = .vertical
//    // put the create sstack view into our nav bar
//    self.titleView = stackView
    
    let textColor = Themes.colorSolidWhite
    let titleLabel = UILabel(frame: CGRectMake(0, -2, 0, 0))

       titleLabel.textColor = textColor
       titleLabel.font = Themes.fontBoldStationSubValues
       titleLabel.text = title
       titleLabel.sizeToFit()

       let subtitleLabel = UILabel(frame: CGRectMake(0, 18, 0, 0))
       subtitleLabel.textColor = textColor.withAlphaComponent(0.75)
       subtitleLabel.font = Themes.fontRegular
       subtitleLabel.text = subtitle
       subtitleLabel.sizeToFit()

       let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
       titleView.addSubview(titleLabel)
       titleView.addSubview(subtitleLabel)

       let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

       if widthDiff < 0 {
           let newX = widthDiff / 2
           subtitleLabel.frame.origin.x = abs(newX)
       } else {
           let newX = widthDiff / 2
           titleLabel.frame.origin.x = newX
       }

    self.titleView = titleView
    
    
  }
}
