//
//  NotificationTimePicker.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import Foundation

protocol NotificationTimeProtocol: NSObject {
  func timeChanged(time: String)
}


class PickerView: UIView {
  
  weak var delegate: NotificationTimeProtocol?
  
  let pickerData = ["5 minutes ago", "10 minutes ago", "15 minutes ago", "30 minutes ago", "1 hour ago", "2 hours ago", "3 hours ago"]
  var selecterRow = 0
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
    let pickker = _inputView as? UIPickerView
    pickker?.dataSource = self
    pickker?.delegate = self
    
    pickker?.backgroundColor = .black
    pickker?.setValue(UIColor.white, forKey: "textColor")

    
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
  
  func startDatePicker() {
    doneClick()
  }
  
  
  
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  @objc private func launchPicker() {
    becomeFirstResponder()
  }
  
  @objc private func doneClick() {
    resignFirstResponder()
    delegate?.timeChanged(time: pickerData[selecterRow])
  }
  
}

extension PickerView: UIPickerViewDataSource {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return pickerData.count;
     }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return pickerData[row]
  }

  
  
  
}

extension PickerView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selecterRow = row
    
  }
}
