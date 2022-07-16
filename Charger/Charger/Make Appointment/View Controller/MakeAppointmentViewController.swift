//
//  MakeAppointmentViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class MakeAppointmentViewController: UIViewController {
  // object connections
  @IBOutlet private weak var statusBarBackgroundView: UIView!
  @IBOutlet private weak var appointmentDatasTableView: UITableView!
  @IBOutlet private weak var confirmAppointmentButton: UIButton!
  
  var appointmentValues: AppointmentDatas?
  var stationName: String?
  private var viewModel = MakeAppointmentViewModel()
  private var tableViewHelper: MakeAppointmentTableViewHelper!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    localization()
    setupController()
  }
  // setup UI
  func setupUI() {
    statusBarBackgroundView.backgroundColor = Themes.colorCharcoal
    confirmAppointmentButton.backgroundColor = Themes.colorSolidWhite  // setup filter button
    confirmAppointmentButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    confirmAppointmentButton.titleLabel?.font = Themes.fontRegularSubtitle
    confirmAppointmentButton.tintColor = Themes.colorDark
  }
  // Localization
  func localization() {
    self.navigationItem.setSubTitle("makeAppointmentTitle".localizeString(), subtitle: stationName!.uppercased())
    confirmAppointmentButton.setTitle("confirmAppointmentButton".localizeString(), for: .normal)
  }
  
  func setupController() {
    tableViewHelper = .init(tableView: appointmentDatasTableView, vm: viewModel)
    tableViewHelper.setItems(appointmentValues!)
    viewModel.appointmentValues = appointmentValues
    viewModel.stationName = stationName
    viewModel.onAppointmentCreated = { [weak self] _ in // when appointment created call the appointment vc
      // Display Appointments page
       let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentsView")
       self?.navigationController?.pushViewController(vc, animated: true)
    }
    
    viewModel.onNotificationError = {[weak self] receivedError in // if notification error received
      self?.openErrorPopUp(error: receivedError, responseHandler: self!.resetNotification)
    }
    viewModel.onAppointmentError = { [weak self] receivedError in
      self?.onServerError(error: receivedError)
    }
  }
  
  // open error pop up according to received error
  func onServerError(error: String) {
    openErrorPopUp(error: error, responseHandler: serverErrorHandler) // call popup func
  }
  /// İf we want to handle server error handle we can write inside this func
  func serverErrorHandler(){}
  
  func resetNotification() {
    viewModel.getNotified = false // set receive notification toggler off
    tableViewHelper.setItems(appointmentValues!) // reload the tableview
  }

  func openErrorPopUp(error: String, responseHandler: @escaping (() -> ())) {
    let popvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopupViewController // instantiate custom popup view
    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.addChild(popvc)
    popvc.view.frame = UIScreen.main.bounds
    UIApplication.shared.windows.last!.addSubview(popvc.view)
    if error == "NOTIFICATION OLDER DATE" { // if the selected date is past we will show the error page according to that
      popvc.setupObjects(
        title: "NOTIFICATION OLDER DATE".localizeString(),
        subtitle: "notificationolderSubtitle".localizeString(),
        confirmButtonLabel:  "notificationErrorConfirmButton".localizeString(),
        cancelButtonLabel: "notificationSecondConfirmButton".localizeString()) // setup pop up elements
      
      popvc.didMove(toParent: self) // open popup
      popvc.secondActionPressed = { [weak self] response in
        responseHandler() // turn off the switch
      } // handle received button press action
    }else if error == "NOTIFICATION NOT ALLOWED"{ // if the notification not allowed
      popvc.setupObjects(
        title: "oldDateTitleError".localizeString(),
        subtitle: "oldDateSubtitleError".localizeString(),
        confirmButtonLabel:  "notificationErrorConfirmButton".localizeString(),
        cancelButtonLabel: "notificationSecondConfirmButton".localizeString()) // setup pop up elements
      
      popvc.didMove(toParent: self) // open popup
      popvc.secondActionPressed = { [weak self] response in
        responseHandler() // turn off the switch
      } // handle received button press action
    }
    else { // if we receive a server error
      popvc.setupObjects(
        title: "receivedServerErrorTitle".localizeString(),
        subtitle: error.localizeString(),
        confirmButtonLabel:  "receivedServerErrorButtonTitle".localizeString(),
        cancelButtonLabel: "zero".localizeString(),hideSecondButton: true)
      popvc.didMove(toParent: self)
    }
  }
  @IBAction func confirmAppointmentButtonPressed(_ sender: UIButton) {
    viewModel.requestAppointment() // when user pressed confirm button call request appointment func
  }
}
