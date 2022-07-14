//
//  DatePickerLabel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import UIKit

protocol DateSelectedDelegate: NSObject {
  /// let the delegation know the date value has been changed
  func dateChanged(date: String)
}

class DatePickerLabel: UILabel {
  weak var delegate: DateSelectedDelegate?

  private var _inputView: UIView? = { // create a custom datepicker closure
    let picker = UIDatePicker()
    picker.preferredDatePickerStyle = .wheels // make the date picker wheel type
    picker.datePickerMode = .date
    
    picker.backgroundColor = Themes.colorDark
    picker.setValue(Themes.colorSolidWhite, forKey: "textColor")
    picker.setValue(false, forKey: "highlightsToday")

    
    let calendar = Calendar.current
    var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
    maxDateComponent.day = 31 // set maximum date to 2022-12-2022
    maxDateComponent.month = 12
    maxDateComponent.year = 2022
    let maxDate = calendar.date(from: maxDateComponent)
    
    picker.maximumDate = maxDate! as Date // set the created maximum date variable
    return picker // reeturn created date picker
  }()
  
  private let _inputAccessoryToolbar: UIToolbar = {
    let toolBar = UIToolbar() // create toolbar
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.barTintColor = .black
    toolBar.tintColor = .white
    toolBar.sizeToFit()
    
    return toolBar
  }()
  
  override var inputView: UIView? {
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
  
  /// to select the first date
  func startDatePicker() {
    doneClick()
  }
  // reset date to today
  func resetDate () {
    let today = DateHandler.shared.getTodayDate() // get today's date
    (_inputView as! UIDatePicker).setDate(today, animated: true)
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  @objc private func launchPicker() {
    becomeFirstResponder()
  }
  
  @objc private func doneClick() {
    resignFirstResponder()
    let getDate = inputView as! UIDatePicker
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"
    let selectedDate = dateFormatter.string(from: getDate.date) // convert the date to type for viewing

    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateData = dateFormatter.string(from: getDate.date) // convert the date for using in the api
    self.delegate?.dateChanged(date: dateData) // let the delegation know the date has been changed
    
    self.text = selectedDate // set the selected date to  current label's text
    
  }
  
}
