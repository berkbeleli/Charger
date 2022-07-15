//
//  OtherDatasTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class OtherDatasTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var otherDatasBackgroundView: UIView!
  @IBOutlet private(set) weak var appointmentInfoTypeLabel: UILabel!
  @IBOutlet private(set) weak var appointmentType: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  // setup view
  func setupUI() {
    appointmentInfoTypeLabel.font = Themes.fontBold
    appointmentInfoTypeLabel.textColor = Themes.colorSolidWhite
    appointmentType.font = Themes.fontRegularSubtitle
    appointmentType.textColor = Themes.colorGrayScale
    otherDatasBackgroundView.backgroundColor = Themes.colorCharcoal
  }
}
