//
//  AppointmentsViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit

class AppointmentsViewController: UIViewController {

  @IBOutlet weak var statusbarBackgroundView: UIView!
  @IBOutlet weak var noappointmentTitleLabel: UILabel!
  @IBOutlet weak var noappointmentSubtitleLabel: UILabel!
  
  @IBOutlet weak var createAppointmentButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    setupUI()
    }
  
  /// Setup UI Elements
  func setupUI() {
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    noappointmentTitleLabel.textColor = Themes.colorSolidWhite
    noappointmentTitleLabel.font = Themes.fontBold
    noappointmentSubtitleLabel.font = Themes.fontRegularSubtitle
    noappointmentSubtitleLabel.textColor = Themes.colorGrayScale
  }
    

  @IBAction func createAppointmentPressed(_ sender: UIButton) {
  }
  

}
