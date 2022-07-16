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
  @IBOutlet private weak var noAppointmentView: UIView!
  @IBOutlet private weak var appointmentsTableView: UITableView!
  
  private var viewModel = AppointmentsViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    localization()
    setupController()
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
    self.navigationItem.hidesBackButton = true // hide back navbar button
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: Themes.UserImage, style: .plain, target: self, action: #selector(profileClicked))
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // with this we will disable back button label text
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "appointmentTitle".localizeString()
    noappointmentTitleLabel.text = "noAppointmentsTitle".localizeString()
    noappointmentSubtitleLabel.text = "noAppointmentsInfo".localizeString()
    createAppointmentButton.setTitle("createAppointmentButton".localizeString(), for: .normal)
  }
  
  func setupController() {
    viewModel.fetchAppointments()
  }
  
  @objc
  func profileClicked() {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileView")
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  
  @IBAction func createAppointmentPressed(_ sender: UIButton) {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelection")
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
