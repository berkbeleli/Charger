//
//  StationTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit
import SkeletonView

class StationTableViewCell: UITableViewCell {
  // Object connections
  @IBOutlet private(set) weak var chargeTypeImage: UIImageView!
  @IBOutlet private(set) weak var stationNameLabel: UILabel!
  @IBOutlet private weak var stationBackgroundView: UIView!
  @IBOutlet private weak var stationSubBackgroundView: UIView!
  @IBOutlet private weak var stationSubBackgroundViewSec: UIView!
  @IBOutlet private weak var workingHoursLabel: UILabel!
  @IBOutlet private(set) weak var workingHours: UILabel!
  @IBOutlet private(set) weak var distanceLabel: UILabel!
  @IBOutlet private weak var availableSocketsTitleLabel: UILabel!
  @IBOutlet private(set) weak var availableSocketLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setupUI()
    localize()
  }
  /// Setup the view of the Table View Cell
  func setupUI() {
    stationBackgroundView.backgroundColor = Themes.colorCharcoal
    stationSubBackgroundView.backgroundColor = Themes.colorDark_2
    stationSubBackgroundViewSec.backgroundColor = Themes.colorDark_2
    stationBackgroundView.layer.cornerRadius = ObjectConstants.viewBorders
    stationSubBackgroundView.layer.cornerRadius = ObjectConstants.viewBorders
    stationSubBackgroundViewSec.layer.cornerRadius = ObjectConstants.viewBorders
    stationNameLabel.font = Themes.fontBold
    stationNameLabel.textColor = Themes.colorSolidWhite
    workingHoursLabel.font = Themes.fontRegularSubtitle
    workingHoursLabel.textColor = Themes.colorGrayScale
    availableSocketsTitleLabel.font = Themes.fontRegularSubtitle
    availableSocketsTitleLabel.textColor = Themes.colorGrayScale
    distanceLabel.font = Themes.fontRegularSubtitle
    distanceLabel.textColor = Themes.colorGrayScale
    workingHours.font = Themes.fontBoldStationSubValues
    workingHours.textColor = Themes.colorSolidWhite
    availableSocketLabel.font = Themes.fontBoldStationSubValues
    availableSocketLabel.textColor = Themes.colorSolidWhite
    stationBackgroundView.isSkeletonable = true
  }
  /// This function makes the view animated
  func startAnimatedSkeletonView() {
    stationBackgroundView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: Themes.colorCharcoal), animation: nil, transition: .crossDissolve(0.25)) // start gradient animation
  }
  /// This function stops the animation
  func stopAnimatedSkeletonView() {
    stationBackgroundView.stopSkeletonAnimation() // stop the animation
    stationBackgroundView.hideSkeleton() // hide the animation
  }
  
  func localize() {
    workingHoursLabel.text = "servicehourTitle".localizeString()
    availableSocketsTitleLabel.text = "availablesocket".localizeString()
  }
  
}
