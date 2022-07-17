//
//  NotificationTimePicker.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import UIKit

protocol NotificationTimeProtocol: NSObject {
  func timeChanged(time: String) // when user changed the selected time
}

class NotificationTimePickerView: UIView {
  weak var delegate: NotificationTimeProtocol?
  let pickerData = ["5m", "10m", "15m", "30m", "60m", "120m", "180m"] // these are predefined localized string
  var selectedRow = 0 // selected row index
  private let _inputView: UIView? = {
    let picker = UIPickerView() // create a picker view
    return picker
  }()
  
  private let _inputAccessoryToolbar: UIToolbar = {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.barTintColor = Themes.colorDark // set tool bar features
    toolBar.tintColor = Themes.colorSolidWhite
    toolBar.sizeToFit()
    return toolBar
  }()
  
  override var inputView: UIView? {
    let picker = _inputView as? UIPickerView
    picker?.dataSource = self // get picker view's delegation and data source to our class
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
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClick)) // create toolbar done button
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil) // create space for our toolbar
    _inputAccessoryToolbar.setItems([ spaceButton, doneButton], animated: false)
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(launchPicker)) // when clicked the view open the picker view create's this gesture here
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
    delegate?.timeChanged(time: pickerData[selectedRow]) // when we click the done button it will inform the delegation
  }
  
}
//MARK: - UIPickerViewDataSource
extension NotificationTimePickerView: UIPickerViewDataSource {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count; // the number of picker view items
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row].localizeString() + " " + "beforetime".localizeString() // adding here before time localization
  }
}
//MARK: - UIPickerViewDelegate
extension NotificationTimePickerView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedRow = row
  }
}
