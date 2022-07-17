//
//  FilterStationsViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

class FilterStationsViewController: UIViewController {
  // object connections
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var deviceTypeHeaderLabel: UILabel!
  @IBOutlet private weak var acDeviceTypeButton: UIButton!
  @IBOutlet private weak var dcDeviceTypeButton: UIButton!
  @IBOutlet private weak var socketTypeHeaderLabel: UILabel!
  @IBOutlet private weak var type2Button: UIButton!
  @IBOutlet private weak var cscButton: UIButton!
  @IBOutlet private weak var chademoButton: UIButton!
  @IBOutlet private weak var distanceHeaderLabel: UILabel!
  @IBOutlet private weak var distanceSlider: UISlider!
  @IBOutlet private weak var fistSliderLabel: UILabel!
  @IBOutlet private weak var secondSliderLabel: UILabel!
  @IBOutlet private weak var thirdSliderLabel: UILabel!
  @IBOutlet private weak var fourthSliderLabel: UILabel!
  @IBOutlet private weak var fifthSliderLabel: UILabel!
  @IBOutlet private weak var servicesHeaderLabel: UILabel!
  @IBOutlet private weak var carParkButton: UIButton!
  @IBOutlet private weak var buffetButton: UIButton!
  @IBOutlet private weak var wifiButton: UIButton!
  @IBOutlet private weak var filterButton: UIButton!
  
  var filterValues: FilterModel?
  var onfilterChanged: ((FilterModel) -> ())?
  var viewModel = FilterStationsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    localization()
    setupController()
  }
  
  /// Setup UI Elements
  func setupUI() {
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    
    acDeviceTypeButton.layer.borderWidth = 2 // setup ac button
    acDeviceTypeButton.titleLabel?.font = Themes.fontRegular
    acDeviceTypeButton.tintColor = Themes.colorSolidWhite
    acDeviceTypeButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    dcDeviceTypeButton.layer.borderWidth = 2  // setup dc button
    dcDeviceTypeButton.titleLabel?.font = Themes.fontRegular
    dcDeviceTypeButton.tintColor = Themes.colorSolidWhite
    dcDeviceTypeButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    type2Button.layer.borderWidth = 2  // setup type2 button
    type2Button.titleLabel?.font = Themes.fontRegular
    type2Button.tintColor = Themes.colorSolidWhite
    type2Button.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    cscButton.layer.borderWidth = 2  // setup csc button
    cscButton.titleLabel?.font = Themes.fontRegular
    cscButton.tintColor = Themes.colorSolidWhite
    cscButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    chademoButton.layer.borderWidth = 2  // setup chademo button
    chademoButton.titleLabel?.font = Themes.fontRegular
    chademoButton.tintColor = Themes.colorSolidWhite
    chademoButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    carParkButton.layer.borderWidth = 2 // setup carpark button
    carParkButton.titleLabel?.font = Themes.fontRegular
    carParkButton.tintColor = Themes.colorSolidWhite
    carParkButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    buffetButton.layer.borderWidth = 2  // setup buffet button
    buffetButton.titleLabel?.font = Themes.fontRegular
    buffetButton.tintColor = Themes.colorSolidWhite
    buffetButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    wifiButton.layer.borderWidth = 2  // setup wifi button
    wifiButton.titleLabel?.font = Themes.fontRegular
    wifiButton.tintColor = Themes.colorSolidWhite
    wifiButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    filterButton.backgroundColor = Themes.colorSolidWhite  // setup filter button
    filterButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    filterButton.titleLabel?.font = Themes.fontRegularSubtitle
    filterButton.tintColor = Themes.colorDark
    
    deviceTypeHeaderLabel.font = Themes.fontExtraBold
    deviceTypeHeaderLabel.textColor = Themes.colorSolidWhite
    socketTypeHeaderLabel.font = Themes.fontExtraBold
    socketTypeHeaderLabel.textColor = Themes.colorSolidWhite
    distanceHeaderLabel.font = Themes.fontExtraBold
    distanceHeaderLabel.textColor = Themes.colorSolidWhite
    servicesHeaderLabel.font = Themes.fontExtraBold
    servicesHeaderLabel.textColor = Themes.colorSolidWhite
    distanceSlider.tintColor = Themes.colorSelectedGreen
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "clearButton".localizeString(), style: .done, target: self, action: #selector(emptyFilters))
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self // allow swipe to back page
  }
  
  /// Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "filterselectionTitle".localizeString()
    deviceTypeHeaderLabel.text = "DeviceTypeHeader".localizeString()
    socketTypeHeaderLabel.text = "SocketTypeHeader".localizeString()
    distanceHeaderLabel.text = "DistanceHeader".localizeString()
    servicesHeaderLabel.text = "servicesTitle".localizeString()
    acDeviceTypeButton.setTitle("AC", for: .normal)
    dcDeviceTypeButton.setTitle("dcbutton".localizeString(), for: .normal)
    type2Button.setTitle("Type 2", for: .normal)
    cscButton.setTitle("CSC", for: .normal)
    chademoButton.setTitle("CHAdeMO", for: .normal)
    carParkButton.setTitle("carpark".localizeString(), for: .normal)
    buffetButton.setTitle("buffet".localizeString(), for: .normal)
    wifiButton.setTitle("Wi-Fi", for: .normal)
    filterButton.setTitle("filterButton".localizeString(), for: .normal)
  }
  
  func setupController() {
    viewModel.filterValues = filterValues ?? FilterModel(deviceTypes: [], socketTypes: [], services: [])
    viewModel.updateFilters()
    self.setupUIElements()
    viewModel.onFiltersChanged = {[weak self] _ in
      // check the filter values for the ac device type and setup the button view
      self?.setupUIElements()
      
    }
  }
  
  func setupUIElements() {
    if self.viewModel.checkContainsDeviceValue(filter: .AC) {
      self.acDeviceTypeButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.acDeviceTypeButton.backgroundColor = Themes.colorDark
    }else {
      self.acDeviceTypeButton.layer.borderColor = Themes.colorGrayScale.cgColor
      self.acDeviceTypeButton.backgroundColor = .clear
    }
    // check the filter values for the dc device type  and setup the button view
    if self.viewModel.checkContainsDeviceValue(filter: .DC) {
      self.dcDeviceTypeButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.dcDeviceTypeButton.backgroundColor = Themes.colorDark
    }else {
      self.dcDeviceTypeButton.layer.borderColor = Themes.colorGrayScale.cgColor
      self.dcDeviceTypeButton.backgroundColor = .clear
    }
    // check the filter values for the type 2 socket type  and setup the button view
    if self.viewModel.checkContainsSocketValue(filter: .Type2) {
      self.type2Button.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.type2Button.backgroundColor = Themes.colorDark
    }else {
      self.type2Button.layer.borderColor = Themes.colorGrayScale.cgColor
      self.type2Button.backgroundColor = .clear
    }
    // check the filter values for the csc socket type  and setup the button view
    if self.viewModel.checkContainsSocketValue(filter: .CSC) {
      self.cscButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.cscButton.backgroundColor = Themes.colorDark
    }else {
      self.cscButton.layer.borderColor = Themes.colorGrayScale.cgColor
      self.cscButton.backgroundColor = .clear
    }
    // check the filter values for the chademo socket type  and setup the button view
    if self.viewModel.checkContainsSocketValue(filter: .CHAdeMO) {
      self.chademoButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.chademoButton.backgroundColor = Themes.colorDark
    }else {
      self.chademoButton.layer.borderColor = Themes.colorGrayScale.cgColor
      self.chademoButton.backgroundColor = .clear
    }
    // check the filter values for the car park service type  and setup the button view
    if self.viewModel.checkContainsServiceValue(filter: .CarPark) {
      self.carParkButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.carParkButton.backgroundColor = Themes.colorDark
    }else {
      self.carParkButton.layer.borderColor = Themes.colorGrayScale.cgColor
      self.carParkButton.backgroundColor = .clear
    }
    // check the filter values for the buffet service type  and setup the button view
    if self.viewModel.checkContainsServiceValue(filter: .Buffet) {
      self.buffetButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.buffetButton.backgroundColor = Themes.colorDark
    }else {
      self.buffetButton.layer.borderColor = Themes.colorGrayScale.cgColor
      self.buffetButton.backgroundColor = .clear
    }
    // check the filter values for the wifi service type  and setup the button view
    if self.viewModel.checkContainsServiceValue(filter: .Wifi) {
      self.wifiButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
      self.wifiButton.backgroundColor = Themes.colorDark
    }else {
      self.wifiButton.layer.borderColor = Themes.colorGrayScale.cgColor
      self.wifiButton.backgroundColor = .clear
    }
    
    if (self.viewModel.checkDistanceExist() ) {
      self.distanceSlider.value = viewModel.getDistanceValue()
    }else {
      self.distanceSlider.value = 15
    }
  }
  
  @IBAction func acButtonPressed(_ sender: UIButton) {
    viewModel.addDeviceFilter(filter: .AC) // adding ac value or removing
  }
  
  @IBAction func dcButtonPressed(_ sender: UIButton) {
    viewModel.addDeviceFilter(filter: .DC) // adding dc value or removing
  }
  
  @IBAction func type2ButtonPressed(_ sender: UIButton) {
    viewModel.addSocketFilter(filter: .Type2) // adding type 2 value or removing
  }
  
  @IBAction func cscButtonPressed(_ sender: UIButton) {
    viewModel.addSocketFilter(filter: .CSC) // adding csc value or removing
  }
  
  @IBAction func chademoButtonPressed(_ sender: UIButton) {
    viewModel.addSocketFilter(filter: .CHAdeMO) // adding chademo value or removing
  }
  
  
  @IBAction func carParkButtonPressed(_ sender: UIButton) {
    viewModel.addServiceFilter(filter: .CarPark) // adding car park value or removing
  }
  
  @IBAction func buffetButtonPressed(_ sender: UIButton) {
    viewModel.addServiceFilter(filter: .Buffet) // adding the buffet value or removing
  }
  
  @IBAction func wifiButtonPressed(_ sender: UIButton) {
    viewModel.addServiceFilter(filter: .Wifi) // adding the wifi value or removing
  }
  
  @IBAction func distanceSliderChanged(_ sender: UISlider) {
    viewModel.addDistanceFilter(filter: Double(sender.value)) // adding the distance value or removing
  }
  // after
  @IBAction func filterButtonPressed(_ sender: UIButton) {
    self.filterValues = viewModel.requestAllFilters()
    onfilterChanged?(filterValues!)
    navigationController?.popViewController(animated: true)
  }
  
  @objc
  func emptyFilters() {
    viewModel.clearFilters()
  }
  
}

//MARK: - UIGestureRecognizerDelegate
extension FilterStationsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // allow slide to back page feature
    }
}
