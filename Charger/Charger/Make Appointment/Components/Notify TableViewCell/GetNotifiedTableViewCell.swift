//
//  GetNotifiedTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class GetNotifiedTableViewCell: UITableViewCell {
  // object connections
  @IBOutlet private weak var getNotifiedBackgroundView: UIView!
  @IBOutlet private weak var getNotifiedHeadLabel: UILabel!
  @IBOutlet private(set) weak var notifySwift: UISwitch!
  var togglerChanged: ((String) -> ())?
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
    localization()
  }
  
  // setup view
  func setupUI() {
    getNotifiedHeadLabel.font = Themes.fontBoldMakeAppInfoType
    getNotifiedHeadLabel.textColor = Themes.colorSolidWhite
    notifySwift.tintColor = Themes.colorSelectedGreen
    getNotifiedBackgroundView.backgroundColor = Themes.colorCharcoal
  }
  // localize the string
  func localization() {
    getNotifiedHeadLabel.text = "getNotify".localizeString()
  }
  /// set switch to on
  func setSwitchOn() {
    notifySwift.isOn = true
  }
  /// set switch to off
  func setSwitchOff() {
    notifySwift.isOn = false
  }
  /// handler switch toggle function with closure
  @IBAction func notifyToggled(_ sender: UISwitch) {
    if sender.isOn {
      togglerChanged?("ON")
    }else {
      togglerChanged?("OFF")
    }
  }
}
