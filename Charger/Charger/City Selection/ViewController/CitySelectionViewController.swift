//
//  CitySelectionViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

class CitySelectionViewController: UIViewController {
  
  @IBOutlet private weak var searchCityTextField: UITextField!
  @IBOutlet private weak var indicatorView: UIView!
  @IBOutlet private weak var cityTableView: UITableView!
  
  private var viewModel = CitySelectionViewModel()
  private var tableViewHelper: CitySelectionTableViewHelper!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCustomSearchTextField()
    setupUI()
    localization()
    setupController()
  }
  
  func setupUI(){
    searchCityTextField.textColor = Themes.colorSolidWhite
    searchCityTextField.font = Themes.fontRegularSubtitle
    indicatorView.backgroundColor = Themes.colorGrayScale
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "cityselectionTitle".localizeString()
  }
  
  func setupCustomSearchTextField(){
    searchCityTextField.layer.cornerRadius = ObjectConstants.searchTextFiledBorderRadies
    searchCityTextField.backgroundColor = Themes.colorDark
    searchCityTextField.clipsToBounds = true // to make text field radiues rounded
    searchCityTextField.layer.borderWidth = 2 // border width for the textfield
    searchCityTextField.layer.borderColor = Themes.colorGrayScale.cgColor // border color for the textfield
    searchCityTextField.attributedPlaceholder = NSAttributedString(
      string:  "searchCityPlaceHolder".localizeString(),
        attributes: [NSAttributedString.Key.foregroundColor: Themes.colorGrayScale]
    )  // set textField placeholder color
    searchCityTextField.setIcon(UIImage(systemName: "magnifyingglass")!) // set left view of the text field
    let imageView = UIImageView(image: UIImage(systemName: "xmark.circle.fill")) // set right cancel button image
    imageView.tintColor = Themes.colorGrayScale // set cancel button color
    imageView.frame = CGRect(x: 0, y: 0, width: 25 , height: 25)
    let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
    paddingView.addSubview(imageView)
    imageView.center = CGPoint(x: paddingView.frame.size.width  / 2,
                               y: paddingView.frame.size.height / 2)
    searchCityTextField.rightViewMode = .whileEditing // make cancel button visible when editing the text filed
    searchCityTextField.rightView = paddingView
    imageView.isUserInteractionEnabled = true
    let cancelButton = UITapGestureRecognizer(target: self, action: #selector(clearTextField)) // add gesture func to our cancel button image
    imageView.addGestureRecognizer(cancelButton)// add gesture to our cancel button image
  }
  
  func setupController(){
    tableViewHelper = .init(with: cityTableView, vm: viewModel)
    viewModel.onCitiesChanged = { [weak self] cities in
      self?.tableViewHelper.setItems(cities)
    }
    viewModel.onCitiesError = { [weak self] receivedError in
      // show received error custom error page
    }
  }
  
  @objc
  func clearTextField() {
    searchCityTextField.text = ""
    searchCityTextField.layer.borderColor = Themes.colorGrayScale.cgColor // border color for the textfield
  }
  
}
