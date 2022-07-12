//
//  ProfileViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit

class ProfileViewController: UIViewController {
  // Object Connections
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var profileBadgeImage: UIImageView!
  @IBOutlet private weak var infoBackgroundView: UIView!
  @IBOutlet private weak var emailTitleLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var deviceUdIdTitleLabel: UILabel!
  @IBOutlet private weak var deviceUdIdLabel: UILabel!
  @IBOutlet private weak var logoutButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
    setupUI()
    localization()
    
    }
  
  /// Setup UI Elements
  func setupUI() {
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    infoBackgroundView.backgroundColor = Themes.colorCharcoal
    infoBackgroundView.layer.cornerRadius = ObjectConstants.viewBorders
    emailLabel.textColor = Themes.colorSolidWhite
    emailLabel.font = Themes.fontBold
    emailTitleLabel.font = Themes.fontRegularSubtitle
    emailTitleLabel.textColor = Themes.colorGrayScale
    deviceUdIdLabel.textColor = Themes.colorSolidWhite
    deviceUdIdLabel.font = Themes.fontBold
    deviceUdIdTitleLabel.font = Themes.fontRegularSubtitle
    deviceUdIdTitleLabel.textColor = Themes.colorGrayScale
    logoutButton.tintColor = Themes.colorDark
    logoutButton.backgroundColor = Themes.colorSolidWhite
    logoutButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    logoutButton.titleLabel?.font = Themes.fontRegularSubtitle
    profileBadgeImage.image = Themes.profileBadgeImage
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "profileTitle".localizeString()
    emailTitleLabel.text = "email".localizeString()
    deviceUdIdTitleLabel.text = "deviceID".localizeString()
    logoutButton.setTitle("logoutButton".localizeString(), for: .normal)
  }

  @IBAction func logOutPressed(_ sender: UIButton) {
  }
  
}
