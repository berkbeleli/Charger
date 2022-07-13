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
    acDeviceTypeButton.layer.borderWidth = 2 // setup ac button
    acDeviceTypeButton.layer.borderColor = Themes.colorGrayScale.cgColor
    acDeviceTypeButton.backgroundColor = .clear
    acDeviceTypeButton.titleLabel?.font = Themes.fontRegular
    acDeviceTypeButton.tintColor = Themes.colorSolidWhite
    acDeviceTypeButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius

    dcDeviceTypeButton.layer.borderWidth = 2  // setup dc button
    dcDeviceTypeButton.layer.borderColor = Themes.colorGrayScale.cgColor
    dcDeviceTypeButton.backgroundColor = .clear
    dcDeviceTypeButton.titleLabel?.font = Themes.fontRegular
    dcDeviceTypeButton.tintColor = Themes.colorSolidWhite
    dcDeviceTypeButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    type2Button.layer.borderWidth = 2  // setup type2 button
    type2Button.layer.borderColor = Themes.colorGrayScale.cgColor
    type2Button.backgroundColor = .clear
    type2Button.titleLabel?.font = Themes.fontRegular
    type2Button.tintColor = Themes.colorSolidWhite
    type2Button.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    cscButton.layer.borderWidth = 2  // setup csc button
    cscButton.layer.borderColor = Themes.colorGrayScale.cgColor
    cscButton.backgroundColor = .clear
    cscButton.titleLabel?.font = Themes.fontRegular
    cscButton.tintColor = Themes.colorSolidWhite
    cscButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    chademoButton.layer.borderWidth = 2  // setup chademo button
    chademoButton.layer.borderColor = Themes.colorGrayScale.cgColor
    chademoButton.backgroundColor = .clear
    chademoButton.titleLabel?.font = Themes.fontRegular
    chademoButton.tintColor = Themes.colorSolidWhite
    chademoButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    carParkButton.layer.borderWidth = 2 // setup carpark button
    carParkButton.layer.borderColor = Themes.colorGrayScale.cgColor
    carParkButton.backgroundColor = .clear
    carParkButton.titleLabel?.font = Themes.fontRegular
    carParkButton.tintColor = Themes.colorSolidWhite
    carParkButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    buffetButton.layer.borderWidth = 2  // setup buffet button
    buffetButton.layer.borderColor = Themes.colorGrayScale.cgColor
    buffetButton.backgroundColor = .clear
    buffetButton.titleLabel?.font = Themes.fontRegular
    buffetButton.tintColor = Themes.colorSolidWhite
    buffetButton.layer.cornerRadius = ObjectConstants.filterbuttonBorderRadius
    
    wifiButton.layer.borderWidth = 2  // setup wifi button
    wifiButton.layer.borderColor = Themes.colorGrayScale.cgColor
    wifiButton.backgroundColor = .clear
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
    
    viewModel.onFiltersChanged = {[weak self] _ in
      // check the filter values for the ac device type and setup the button view
      if self?.viewModel.checkContainsDeviceValue(filter: .AC) ?? false {
        self?.acDeviceTypeButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.acDeviceTypeButton.backgroundColor = Themes.colorDark
      }else {
        self?.acDeviceTypeButton.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.acDeviceTypeButton.backgroundColor = .clear
      }
      // check the filter values for the dc device type  and setup the button view
      if self?.viewModel.checkContainsDeviceValue(filter: .DC) ?? false {
        self?.dcDeviceTypeButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.dcDeviceTypeButton.backgroundColor = Themes.colorDark
      }else {
        self?.dcDeviceTypeButton.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.dcDeviceTypeButton.backgroundColor = .clear
      }
      // check the filter values for the type 2 socket type  and setup the button view
      if self?.viewModel.checkContainsSocketValue(filter: .Type2) ?? false {
        self?.type2Button.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.type2Button.backgroundColor = Themes.colorDark
      }else {
        self?.type2Button.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.type2Button.backgroundColor = .clear
      }
      // check the filter values for the csc socket type  and setup the button view
      if self?.viewModel.checkContainsSocketValue(filter: .CSC) ?? false {
        self?.cscButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.cscButton.backgroundColor = Themes.colorDark
      }else {
        self?.cscButton.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.cscButton.backgroundColor = .clear
      }
      // check the filter values for the chademo socket type  and setup the button view
      if self?.viewModel.checkContainsSocketValue(filter: .CHAdeMO) ?? false {
        self?.chademoButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.chademoButton.backgroundColor = Themes.colorDark
      }else {
        self?.chademoButton.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.chademoButton.backgroundColor = .clear
      }
      // check the filter values for the car park service type  and setup the button view
      if self?.viewModel.checkContainsServiceValue(filter: .CarPark) ?? false {
        self?.carParkButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.carParkButton.backgroundColor = Themes.colorDark
      }else {
        self?.carParkButton.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.carParkButton.backgroundColor = .clear
      }
      // check the filter values for the buffet service type  and setup the button view
      if self?.viewModel.checkContainsServiceValue(filter: .Buffet) ?? false {
        self?.buffetButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.buffetButton.backgroundColor = Themes.colorDark
      }else {
        self?.buffetButton.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.buffetButton.backgroundColor = .clear
      }
      // check the filter values for the wifi service type  and setup the button view
      if self?.viewModel.checkContainsServiceValue(filter: .Wifi) ?? false {
        self?.wifiButton.layer.borderColor = Themes.colorSelectedGreen.cgColor
        self?.wifiButton.backgroundColor = Themes.colorDark
      }else {
        self?.wifiButton.layer.borderColor = Themes.colorGrayScale.cgColor
        self?.wifiButton.backgroundColor = .clear
      }
      
      if (self?.viewModel.checkDistanceExist() ?? true) {
        self?.distanceSlider.value = 15
      }
      
    }
    
  }
  
  @IBAction func acButtonPressed(_ sender: UIButton) {
    viewModel.addDeviceFilter(filter: .AC)
  }
  
  @IBAction func dcButtonPressed(_ sender: UIButton) {
    viewModel.addDeviceFilter(filter: .DC)
  }
  
  @IBAction func type2ButtonPressed(_ sender: UIButton) {
    viewModel.addSocketFilter(filter: .Type2)
  }
  
  @IBAction func cscButtonPressed(_ sender: UIButton) {
    viewModel.addSocketFilter(filter: .CSC)
  }
  
  @IBAction func chademoButtonPressed(_ sender: UIButton) {
    viewModel.addSocketFilter(filter: .CHAdeMO)
  }
  
  
  @IBAction func carParkButtonPressed(_ sender: UIButton) {
    viewModel.addServiceFilter(filter: .CarPark)
  }
  
  @IBAction func buffetButtonPressed(_ sender: UIButton) {
    viewModel.addServiceFilter(filter: .Buffet)
  }
  
  @IBAction func wifiButtonPressed(_ sender: UIButton) {
    viewModel.addServiceFilter(filter: .Wifi)
  }
  
  @IBAction func distanceSliderChanged(_ sender: UISlider) {
    viewModel.addDistanceFilter(filter: Double(sender.value))
  }
}
