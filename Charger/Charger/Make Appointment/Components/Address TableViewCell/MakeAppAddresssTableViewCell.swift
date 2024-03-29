//
//  MakeAppAddresssTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class MakeAppAddresssTableViewCell: UITableViewCell {
  //object connections
  @IBOutlet private weak var addressBackgroundView: UIView!
  @IBOutlet private weak var addressHeaderLabel: UILabel!
  @IBOutlet private(set) weak var addressLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
    localization()
  }
  // setup view
  func setupUI() {
    addressHeaderLabel.font = Themes.fontBoldMakeAppointmentHeader
    addressHeaderLabel.textColor = Themes.colorSolidWhite
    addressLabel.font = Themes.fontRegularMakeAppInfo
    addressLabel.textColor = Themes.colorGrayScale
    addressBackgroundView.backgroundColor = Themes.colorCharcoal
  }
  // localize
  func localization() {
    addressHeaderLabel.text = "addres".localizeString()
  }
  
}
