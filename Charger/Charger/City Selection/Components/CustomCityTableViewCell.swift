//
//  CustomCityTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

class CustomCityTableViewCell: UITableViewCell {
  @IBOutlet private weak var bgView: UIView!
  @IBOutlet private(set) weak var cityNameLabel: UILabel!
  @IBOutlet weak var seperatorView: UIView!
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  func setupUI() {
    cityNameLabel.textColor = Themes.colorSolidWhite
    cityNameLabel.font = Themes.fontRegularSubtitle
    seperatorView.backgroundColor = Themes.colorGrayScale
  }
}
