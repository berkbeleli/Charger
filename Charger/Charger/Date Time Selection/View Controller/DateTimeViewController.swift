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
  
  func setupDatePickerLabel() {
    (appointmentSelectorLabel as? DatePickerLabel)?.delegate = self // get datepicker label's delegation
    (appointmentSelectorLabel as? DatePickerLabel)?.startDatePicker() // select today's date
  }
  
  func setupController() {
    viewModel.onViewsSocketsChanged = { [weak self] viewDatas in
      
      if viewDatas.count == 1 {
        self?.socketFirstTypeLabel.text = viewDatas[0]
        self?.socketFirstTableeviewWidth = self?.socketFirstTableeviewWidth.setMultiplier(multiplier: 0.9) // change the width of the table view
        self?.socketSecondHolderView.isHidden = true
        self?.socketThirdHolderView.isHidden = true
      }else if viewDatas.count == 2 {
        self?.socketFirstTypeLabel.text = viewDatas[0]
        self?.socketSecondTypeLabel.text = viewDatas[1]
        self?.socketFirstTableeviewWidth = self?.socketFirstTableeviewWidth.setMultiplier(multiplier: 0.45) // change the width of the table view
        self?.socketSecondTableeviewWidth = self?.socketSecondTableeviewWidth.setMultiplier(multiplier: 0.45) // change the width of the table view
        self?.socketSecondHolderView.isHidden = false
        self?.socketThirdHolderView.isHidden = true
        
      }else {
        self?.socketFirstTypeLabel.text = viewDatas[0]
        self?.socketSecondTypeLabel.text = viewDatas[1]
        self?.socketThirdTypeLabel.text = viewDatas[2]
        self?.socketFirstTableeviewWidth = self?.socketFirstTableeviewWidth.setMultiplier(multiplier: 0.3) // change the width of the table view
        self?.socketSecondTableeviewWidth = self?.socketSecondTableeviewWidth.setMultiplier(multiplier: 0.3) // change the width of the table view
        self?.socketThirdTableeViewWidth = self?.socketFirstTableeviewWidth.setMultiplier(multiplier: 0.3) // change the width of the table view
        self?.socketSecondHolderView.isHidden = false
        self?.socketThirdHolderView.isHidden = false
      }
    }
    
    tableViewHelper = .init(
      tableViewFirst: socketFirstTableView,
      tableViewSecond: socketSecondTableView,
      tableViewThird: socketThirdTableView,
      vm: viewModel)
    viewModel.onTimesChanged = {[weak self] receivedTimes in
      self?.tableViewHelper.setItems(receivedTimes)
    }
    
  }
  
  
  
  @IBAction func confirmTimePressed(_ sender: UIButton) {
  }
  
  
}

extension DateTimeViewController: DateSelectedDelegate {
  func dateChanged(date: String) {
    viewModel.fetchTimes(stationId: "\(stationId!)", date: date) // fetch the times according to the selected date
  }
}
