//
//  NotificationTimePicker.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import UIKit

protocol NotificationTimeProtocol: NSObject {
  func timeChanged(time: String)
}


class NotificationTimePickerView: UIView {
  
  weak var delegate: NotificationTimeProtocol?
  
  let pickerData = ["5m", "10m", "15m", "30m", "60m", "120m", "180m"]
  var selectedRow = 0
  private let _inputView: UIView? = {
    let picker = UIPickerView()
    return picker
  }()
  
  private let _inputAccessoryToolbar: UIToolbar = {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.barTintColor = Themes.colorDark
    toolBar.tintColor = Themes.colorSolidWhite
    toolBar.sizeToFit()
    return toolBar
  }()
  
  override var inputView: UIView? {
    let picker = _inputView as? UIPickerView
    picker?.dataSource = self
    picker?.delegate = self
    picker?.backgroundColor = Themes.colorDark
    picker?.setValue(Themes.colorSolidWhite, forKey: "textColor")
    return _inputView
  }
  
  override var inputAccessoryView: UIView? {
    return _inputAccessoryToolbar
  }
  
  required init?(coder aDecoder: NSCoder?) {
    super.init(coder: aDecoder ?? NSCoder())
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    _inputAccessoryToolbar.setItems([ spaceButton, doneButton], animated: false)
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(launchPicker))
    self.addGestureRecognizer(tapRecognizer)
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  @objc private func launchPicker() {
    becomeFirstResponder()
  }
  
  @objc private func doneClick() {
    resignFirstResponder()
    delegate?.timeChanged(time: pickerData[selectedRow])
  }
  
}

extension NotificationTimePickerView: UIPickerViewDataSource {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count;
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row].localizeString()
  }
}

extension NotificationTimePickerView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedRow = row
  }
}
