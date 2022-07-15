//
//  MakeAppointmentViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class MakeAppointmentViewController: UIViewController {
  
  @IBOutlet private weak var statusBarBackgroundView: UIView!
  @IBOutlet private weak var appointmentDatasTableView: UITableView!
  @IBOutlet private weak var confirmAppointmentButton: UIButton!
  
  var appointmentValues: AppointmentDatas?
  var stationName: String?
  
  var viewModel = MakeAppointmentViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    localization()
  }
  
  func setupUI() {
    statusBarBackgroundView.backgroundColor = Themes.colorCharcoal
    confirmAppointmentButton.backgroundColor = Themes.colorSolidWhite  // setup filter button
    confirmAppointmentButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    confirmAppointmentButton.titleLabel?.font = Themes.fontRegularSubtitle
    confirmAppointmentButton.tintColor = Themes.colorDark
  }
  
  func localization() {
    self.navigationItem.setSubTitle("makeAppointmentTitle".localizeString(), subtitle: stationName!.uppercased())
    confirmAppointmentButton.setTitle("confirmAppointmentButton", for: .normal)
  }
  
  @IBAction func confirmAppointmentButtonPressed(_ sender: UIButton) {
    viewModel.createAppointment()
  }
  
  
}
