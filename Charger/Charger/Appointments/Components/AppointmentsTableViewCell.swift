//
//  AppointmentsTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import UIKit

class AppointmentsTableViewCell: UITableViewCell {
  var deleteAppointment: ((String) -> ())?
 // object connections
  @IBOutlet private(set) weak var appointmentChargeTypeImage: UIImageView!
  @IBOutlet private(set) weak var stationNameLabel: UILabel!
  @IBOutlet private(set) weak var deleteAppointmentButton: UIButton!
  @IBOutlet private weak var appointmentBackgroundView: UIView!
  @IBOutlet private weak var appointmentSubBackgroundView: UIView!
  @IBOutlet private weak var appointmentSubBackgrounViewSec: UIView!
  @IBOutlet private(set) weak var appointmentTimeLabel: UILabel!
  @IBOutlet private(set) weak var notificationTimeView: UIStackView!
  @IBOutlet private(set) weak var notificationTimeLabel: UILabel!
  @IBOutlet private(set) weak var outsourcePowerLabel: UILabel!
  @IBOutlet private weak var socketNumberTitleLabel: UILabel!
  @IBOutlet private(set) weak var socketNumberLabel: UILabel!
  @IBOutlet private(set) weak var chargeAndSocketTypeLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        localization()
    }
  
  /// Setup the view of the Table View Cell
  func setupUI() {
    appointmentBackgroundView.backgroundColor = Themes.colorCharcoal
    appointmentSubBackgroundView.backgroundColor = Themes.colorDark_2
    appointmentSubBackgrounViewSec.backgroundColor = Themes.colorDark_2
    appointmentBackgroundView.layer.cornerRadius = ObjectConstants.viewBorders
    appointmentSubBackgroundView.layer.cornerRadius = ObjectConstants.viewBorders
    appointmentSubBackgrounViewSec.layer.cornerRadius = ObjectConstants.viewBorders
    stationNameLabel.font = Themes.fontBold
    stationNameLabel.textColor = Themes.colorSolidWhite
    appointmentTimeLabel.font = Themes.fontBoldAppointmentSubValues
    appointmentTimeLabel.textColor = Themes.colorSolidWhite
    notificationTimeLabel.font = Themes.fontBoldAppointmentSubValues
    notificationTimeLabel.textColor = Themes.colorSolidWhite
    outsourcePowerLabel.font = Themes.fontRegularAppointmentSubtitle
    outsourcePowerLabel.textColor = Themes.colorGrayScale
    socketNumberTitleLabel.font = Themes.fontRegularAppointmentSubtitle
    socketNumberTitleLabel.textColor = Themes.colorGrayScale
    socketNumberLabel.font = Themes.fontBoldAppointmentSubValues
    socketNumberLabel.textColor = Themes.colorSolidWhite
    chargeAndSocketTypeLabel.font = Themes.fontRegularAppointmentSubtitle
    chargeAndSocketTypeLabel.textColor = Themes.colorGrayScale
    deleteAppointmentButton.tintColor = Themes.colorSolidWhite
  }
  
  func localization() {
    socketNumberTitleLabel.text = "appointmentPageSocket".localizeString()
  }
  
  @IBAction func deleteAppointmentPressed(_ sender: UIButton) {
    deleteAppointment?("deleted")
  }
  
}
