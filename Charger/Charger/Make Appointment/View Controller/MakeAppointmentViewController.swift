//
//  MakeAppointmentViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class MakeAppointmentViewController: UIViewController {

  @IBOutlet private weak var appointmentDatasTableView: UITableView!
  @IBOutlet private weak var confirmAppointmentButton: UIButton!
  
  var appointmentValues: AppointmentDatas?
  
  override func viewDidLoad() {
        super.viewDidLoad()

    
    }
  
  func setupUI() {
    confirmAppointmentButton.backgroundColor = Themes.colorSolidWhite  // setup filter button
    confirmAppointmentButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    confirmAppointmentButton.titleLabel?.font = Themes.fontRegularSubtitle
    confirmAppointmentButton.tintColor = Themes.colorDark
  }
  
  func localization() {
    confirmAppointmentButton.setTitle("confirmAppointmentButton", for: .normal)
  }
  
  
  
  
  @IBAction func confirmAppointmentButtonPressed(_ sender: UIButton) {
  }
  
    
}
