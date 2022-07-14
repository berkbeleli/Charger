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
    let textColor = Themes.colorSolidWhite
    // title label types
    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = Themes.fontBoldStationSubValues
    titleLabel.textColor = textColor
    // subtitle label types
    let subtitleLabel = UILabel()
    subtitleLabel.text = subtitle
    subtitleLabel.font = Themes.fontRegular
    subtitleLabel.textColor = textColor.withAlphaComponent(0.75)
    // create with these 2 labels a stacck view
    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stackView.distribution = .equalCentering
    stackView.alignment = .center
    stackView.axis = .vertical
    // put the create sstack view into our nav bar
    self.titleView = stackView
  }
}
