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
  @IBOutlet private var socketFirstTableeviewWidth: NSLayoutConstraint! // I have to manage it strong to keep its value
  @IBOutlet private weak var socketSecondHolderView: UIStackView!
  @IBOutlet private weak var socketSecondHeaderLabel: UILabel!
  @IBOutlet private weak var socketSecondTypeLabel: UILabel!
  @IBOutlet private weak var socketSecondTableView: UITableView!
  @IBOutlet private var socketSecondTableeviewWidth: NSLayoutConstraint!  // I have to manage it strong to keep its value
  @IBOutlet private weak var socketThirdHolderView: UIStackView!
  @IBOutlet private weak var socketThirdHeaderLabel: UILabel!
  @IBOutlet private weak var socketThirdTypeLabel: UILabel!
  @IBOutlet private weak var socketThirdTableView: UITableView!
  @IBOutlet private var socketThirdTableeViewWidth: NSLayoutConstraint! // I have to manage it strong to keep its value
  @IBOutlet private weak var confirmTimeButton: UIButton!
  // we will receive this datas from the station view
  var stationId: Int?
  var stationName: String?
  var distance: String?
  
  private var viewModel = DateTimeViewModel()
  private var tableViewHelper: TimeSelectionTableViewHelper!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    localization()
    setupDatePickerLabel()
    setupController()
    deactivateConfirmButton()
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
  /// Setup DatePicker
  func setupDatePickerLabel() {
    (appointmentSelectorLabel as? DatePickerLabel)?.delegate = self // get datepicker label's delegation
    (appointmentSelectorLabel as? DatePickerLabel)?.startDatePicker() // select today's date
  }
  /// Activate the confirm Button
  func activateConfirmButton() {
    confirmTimeButton.isUserInteractionEnabled = true
    UIView.animate(withDuration: 0.5) {
      self.confirmTimeButton.backgroundColor = Themes.colorSolidWhite  // setup confirm button
      self.confirmTimeButton.tintColor = Themes.colorDark
    }
  }
  
  func deactivateConfirmButton() {
    confirmTimeButton.backgroundColor = Themes.colorCharcoal  // setup confirm button
    confirmTimeButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    confirmTimeButton.titleLabel?.font = Themes.fontRegularSubtitle
    confirmTimeButton.tintColor = Themes.colorGrayScale
    confirmTimeButton.isUserInteractionEnabled = false // disable confirm button
  }
  
  func setupController() {
    viewModel.onViewsSocketsChanged = { [weak self] viewDatas in
      if viewDatas.count == 1 { // checking the number of the sockets
        self?.socketFirstTypeLabel.text = viewDatas[0] // set label
        self?.setupTables(multiplier: 0.9) // set TableViews width
        self?.socketSecondHolderView.isHidden = true // hide socket2
        self?.socketThirdHolderView.isHidden = true // hide socket3
      }else if viewDatas.count == 2 {
        self?.socketFirstTypeLabel.text = viewDatas[0] // set label
        self?.socketSecondTypeLabel.text = viewDatas[1] // set label
        self?.setupTables(multiplier: 0.45)// set TableViews width
        self?.socketSecondHolderView.isHidden = false// show socket2
        self?.socketThirdHolderView.isHidden = true // hide socket3
      }else {
        self?.socketFirstTypeLabel.text = viewDatas[0] // set label
        self?.socketSecondTypeLabel.text = viewDatas[1] // set label
        self?.socketThirdTypeLabel.text = viewDatas[2] // set label
        self?.setupTables(multiplier: 0.3)// set TableViews width
        self?.socketSecondHolderView.isHidden = false // show socket2
        self?.socketThirdHolderView.isHidden = false // show socket2
      }
    }
    
    tableViewHelper = .init(
      tableViewFirst: socketFirstTableView,
      tableViewSecond: socketSecondTableView,
      tableViewThird: socketThirdTableView,
      vm: viewModel) // initializing the tableviewHelper
    tableViewHelper.delegate = self // getting TableViewDelegation
    viewModel.onTimesChanged = {[weak self] receivedTimes in // times object catched
      self?.tableViewHelper.setItems(receivedTimes)
    }
    viewModel.onTimesError = { [weak self] receivedError in
      if receivedError != "STATION_NOT_ACCEPTING_APPOINTMENTS" { // there is a small bug as catching the datas from  the server it gives this error when we select old date to silent this error as loading time I ignored this error
        self?.onServerError(error: receivedError)
      }
    }
  }
  // open error pop up according to received error
  func onServerError(error: String) {
    openErrorPopUp(error: error, responseHandler: serverErrorHandler)
  }
  /// İf we want to handle server error handle we can write inside this func
  func serverErrorHandler(){}
  /// setup tableView's width with the given multiplier value
  func setupTables(multiplier: Double) {
    self.socketFirstTableeviewWidth = self.socketFirstTableeviewWidth.setMultiplier(multiplier: multiplier) // change the width of the table view
    self.socketSecondTableeviewWidth = self.socketSecondTableeviewWidth.setMultiplier(multiplier: multiplier) // change the width of the table view
    self.socketThirdTableeViewWidth = self.socketFirstTableeviewWidth.setMultiplier(multiplier: multiplier) // change the width of the table view
  }
  
  func openErrorPopUp(error: String, responseHandler: @escaping (() -> ())) {
    let popvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopupViewController // instantiate custom popup view
    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.addChild(popvc)
    popvc.view.frame = UIScreen.main.bounds
    UIApplication.shared.windows.last!.addSubview(popvc.view)
    if error == "DATE ERROR" { // if the selected date is past we will show the error page according to that
      popvc.setupObjects(title: "oldDateTitleError".localizeString(), subtitle: "oldDateSubtitleError".localizeString(), confirmButtonLabel:  "oldDateActionButton".localizeString(), cancelButtonLabel: "oldDateSecondActionButton".localizeString()) // setup pop up elements
      
      popvc.didMove(toParent: self) // open popup
      popvc.secondActionPressed = { [weak self] response in
        self?.resetDatePickerToday()
      } // handle received button press action
    }else {
      popvc.setupObjects(title: "receivedServerErrorTitle".localizeString(), subtitle: error.localizeString(), confirmButtonLabel:  "receivedServerErrorButtonTitle".localizeString(), cancelButtonLabel: "zero".localizeString(),hideSecondButton: true)
      popvc.didMove(toParent: self)
    }
    
  }
  /// reset the selected date picker's date today
  func resetDatePickerToday() {
    (appointmentSelectorLabel as? DatePickerLabel)?.resetDate()
    (appointmentSelectorLabel as? DatePickerLabel)?.startDatePicker()
  }
  
  @IBAction func confirmTimePressed(_ sender: UIButton) {
    let timeControl = viewModel.isDatePast() // checking if the selected date and time older than today
    if timeControl {
      openErrorPopUp(error: "DATE ERROR", responseHandler: resetDatePickerToday)
    }else {
     // Display Appointment Infos page
      let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MakeAppointment") as! MakeAppointmentViewController
      vc.stationName = stationName // sent station Name
      vc.appointmentValues = viewModel.requestAppointmentDatas() // request appointment values from viewmodel
      self.navigationController?.pushViewController(vc, animated: true)
      
    }
  }
}
// MARK: - DateSelectedDelegate
extension DateTimeViewController: DateSelectedDelegate {
  func dateChanged(date: String, dateView: String) {
    viewModel.fetchTimes(stationId: "\(stationId!)", date: date) // fetch the times according to the selected date
    viewModel.setDateAndDistanceValues(date: date, dateView: dateView, distance: distance ?? "-1") // set view models date and distance values if thereis not distance value we will not show in the next page
    deactivateConfirmButton()// deactivate confirm button
  }
}
// MARK: - TimeSelectionProtocol
extension DateTimeViewController: TimeSelectionProtocol {
  func didTimeSelected() {
    activateConfirmButton() // if a time selected we will activate the confirm button
  }
}
