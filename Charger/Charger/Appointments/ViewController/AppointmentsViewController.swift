//
//  AppointmentsViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit

class AppointmentsViewController: UIViewController {
  
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var noappointmentTitleLabel: UILabel!
  @IBOutlet private weak var noappointmentSubtitleLabel: UILabel!
  @IBOutlet private weak var noAppointmentImage: UIImageView!
  @IBOutlet private weak var createAppointmentButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupUI()
    localization()
  }
  
  /// Setup UI Elements
  func setupUI() {
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    noappointmentTitleLabel.textColor = Themes.colorSolidWhite
    noappointmentTitleLabel.font = Themes.fontExtraBold
    noappointmentSubtitleLabel.font = Themes.fontRegularSubtitle
    noappointmentSubtitleLabel.textColor = Themes.colorGrayScale
    createAppointmentButton.tintColor = Themes.colorDark
    createAppointmentButton.backgroundColor = Themes.colorSolidWhite
    createAppointmentButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    createAppointmentButton.titleLabel?.font = Themes.fontRegularSubtitle
    noAppointmentImage.image = Themes.noAppointmentImage
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "appointmentTitle".localizeString()
    noappointmentTitleLabel.text = "noAppointmentsTitle".localizeString()
    noappointmentSubtitleLabel.text = "noAppointmentsInfo".localizeString()
    createAppointmentButton.setTitle("createAppointmentButton".localizeString(), for: .normal)
  }
  
  
  @IBAction func createAppointmentPressed(_ sender: UIButton) {
  }
  
  
}
