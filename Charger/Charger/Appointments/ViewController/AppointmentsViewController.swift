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
  private var tableViewHelper: AppointmentsTableViewHelper!
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
    appointmentsTableView.isHidden = true
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
    tableViewHelper = .init(with: appointmentsTableView, vm: viewModel)
    tableViewHelper.delegate = self
    
    viewModel.onAppointmentsChanged = { [weak self] currentAppointment, pastAppointments in
      self?.tableViewHelper.setItems(currentAppointments: currentAppointment, pastAppointments: pastAppointments)
      if currentAppointment.isEmpty && pastAppointments.isEmpty {
        self?.appointmentsTableView.isHidden = true
        self?.noAppointmentView.isHidden = false
      }else {
        self?.appointmentsTableView.isHidden = false
        self?.noAppointmentView.isHidden = true
      }
    }
  }
  
  @objc
  func profileClicked() {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileView")
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func openErrorPopUp(error: String, appointmentID: String?, stationName: String?,date: String? ,time: String?) {
    let popvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopupViewController // instantiate custom popup view
    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.addChild(popvc)
    popvc.view.frame = UIScreen.main.bounds
    UIApplication.shared.windows.last!.addSubview(popvc.view)

    if error == "DELETEAPPOINTMENT" { // if the selected date is past we will show the error page according to that

      let localizedMsg = String(format: NSLocalizedString("Your appointment at %@ on %@ at %@ will be cancelled.", comment: ""), stationName as! NSString, date as! NSString, time as! NSString)
      
      popvc.setupObjects(
        title: "cancelAppointmentTitle".localizeString(),
        subtitle: localizedMsg,
        confirmButtonLabel:  "confirmButton".localizeString(),
        cancelButtonLabel: "confirmCancelButton".localizeString()) // setup pop up elements
      
      popvc.didMove(toParent: self) // open popup
      popvc.confirmPressed = { [weak self] response in
        self?.viewModel.deleteAppointment(appointmentID: appointmentID!)//delete appointment
      } // handle received button press action
    }else {
      popvc.setupObjects(title: "receivedServerErrorTitle".localizeString(), subtitle: "error".localizeString(), confirmButtonLabel:  "receivedServerErrorButtonTitle".localizeString(), cancelButtonLabel: "zero".localizeString(),hideSecondButton: true)
      popvc.didMove(toParent: self)
    }
  }


  
  
  @IBAction func createAppointmentPressed(_ sender: UIButton) {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelection")
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

//MARK: - AppointmentViewProtocol
extension AppointmentsViewController: AppointmentViewProtocol {
  func didDeletionSelected(appointmentID: String, stationName: String, date: String, time: String) {
    openErrorPopUp(error: "DELETEAPPOINTMENT", appointmentID: appointmentID, stationName: stationName, date: date, time: time)
  }
}
