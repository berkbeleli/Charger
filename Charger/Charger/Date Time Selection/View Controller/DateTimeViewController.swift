//
//  DateTimeViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import UIKit

class DateTimeViewController: UIViewController {
  // object connections
  @IBOutlet private weak var statusBarBackgroundView: UIView!
  @IBOutlet private weak var appointmentTimeHeadLabel: UILabel!
  @IBOutlet private weak var appointmentSelectorLabel: UILabel!
  @IBOutlet private weak var socketFirstHolderView: UIStackView!
  @IBOutlet private weak var socketFirstHeaderLabel: UILabel!
  @IBOutlet private weak var socketFirstTypeLabel: UILabel!
  @IBOutlet private weak var socketFirstTableView: UITableView!
  @IBOutlet private weak var socketFirstTableeviewWidth: NSLayoutConstraint!
  @IBOutlet private weak var socketSecondHolderView: UIStackView!
  @IBOutlet private weak var socketSecondHeaderLabel: UILabel!
  @IBOutlet private weak var socketSecondTypeLabel: UILabel!
  @IBOutlet private weak var socketSecondTableView: UITableView!
  @IBOutlet private weak var socketSecondTableeviewWidth: NSLayoutConstraint!
  @IBOutlet private weak var socketThirdHolderView: UIStackView!
  @IBOutlet private weak var socketThirdHeaderLabel: UILabel!
  @IBOutlet private weak var socketThirdTypeLabel: UILabel!
  @IBOutlet private weak var socketThirdTableView: UITableView!
  @IBOutlet private weak var socketThirdTableeViewWidth: NSLayoutConstraint!
  @IBOutlet private weak var confirmTimeButton: UIButton!
  // we will receive this datas from the station view
  var stationId: Int?
  var stationName: String?
  var distance: String?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    localization()
  }
  
  /// Setup UI Elements
  func setupUI(){
    statusBarBackgroundView.backgroundColor = Themes.colorCharcoal
    appointmentTimeHeadLabel.font = Themes.fontBoldStationSubValues
    appointmentTimeHeadLabel.textColor = Themes.colorSolidWhite
    appointmentSelectorLabel.font = Themes.fontBoldStationSubValues
    appointmentSelectorLabel.textColor = Themes.colorSolidWhite
    socketFirstHeaderLabel.font = Themes.fontBoldStationSubValues
    socketFirstHeaderLabel.textColor = Themes.colorSolidWhite
    socketSecondHeaderLabel.font = Themes.fontBoldStationSubValues
    socketSecondHeaderLabel.textColor = Themes.colorSolidWhite
    socketThirdHeaderLabel.font = Themes.fontBoldStationSubValues
    socketThirdHeaderLabel.textColor = Themes.colorSolidWhite
    socketFirstTypeLabel.font = Themes.fontRegular
    socketFirstTypeLabel.textColor = Themes.colorGrayScale
    socketSecondTypeLabel.font = Themes.fontRegular
    socketSecondTypeLabel.textColor = Themes.colorGrayScale
    socketThirdTypeLabel.font = Themes.fontRegular
    socketThirdTypeLabel.textColor = Themes.colorGrayScale
    confirmTimeButton.backgroundColor = Themes.colorSolidWhite  // setup confirm button
    confirmTimeButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    confirmTimeButton.titleLabel?.font = Themes.fontRegularSubtitle
    confirmTimeButton.tintColor = Themes.colorDark
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // with this we will disable back button label text
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.setSubTitle("timeTitle".localizeString(), subtitle: stationName!.uppercased())
    appointmentTimeHeadLabel.text = "dateIndicator".localizeString()
    socketFirstHeaderLabel.text = "socketHead".localizeString() + " 1"
    socketSecondHeaderLabel.text = "socketHead".localizeString() + " 2"
    socketThirdHeaderLabel.text = "socketHead".localizeString() + " 3"
    confirmTimeButton.setTitle("confirmTimeButton".localizeString(), for: .normal)
  }
  
  
  
  
  @IBAction func confirmTimePressed(_ sender: UIButton) {
  }
  
  
}
