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
    confirmTimeButton.backgroundColor = Themes.colorCharcoal  // setup confirm button
    confirmTimeButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    confirmTimeButton.titleLabel?.font = Themes.fontRegularSubtitle
    confirmTimeButton.tintColor = Themes.colorGrayScale
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // with this we will disable back button label text
    confirmTimeButton.isUserInteractionEnabled = false // disable confirm button
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
  }
  /// setup tableView's width with the given multiplier value
  func setupTables(multiplier: Double) {
    self.socketFirstTableeviewWidth = self.socketFirstTableeviewWidth.setMultiplier(multiplier: multiplier) // change the width of the table view
    self.socketSecondTableeviewWidth = self.socketSecondTableeviewWidth.setMultiplier(multiplier: multiplier) // change the width of the table view
    self.socketThirdTableeViewWidth = self.socketFirstTableeviewWidth.setMultiplier(multiplier: multiplier) // change the width of the table view
  }
  
  @IBAction func confirmTimePressed(_ sender: UIButton) {
    let timeControl = viewModel.isDateOld() // checking if the selected date and time older than today
    if timeControl {
      // display error Page
      print("error Page")
    }else {
      // display next Page
      print("Next Page")
    }
  }
}
// MARK: - DateSelectedDelegate
extension DateTimeViewController: DateSelectedDelegate {
  func dateChanged(date: String) {
    viewModel.fetchTimes(stationId: "\(stationId!)", date: date) // fetch the times according to the selected date
    viewModel.setDateAndDistanceValues(date: date, dateView: appointmentSelectorLabel.text!, distance: distance ?? "-1") // set view models date and distance values if thereis not distance value we will not show in the next page
  }
}
// MARK: - TimeSelectionProtocol
extension DateTimeViewController: TimeSelectionProtocol {
  func didTimeSelected() {
    activateConfirmButton() // if a time selected we will activate the confirm button
  }
}
