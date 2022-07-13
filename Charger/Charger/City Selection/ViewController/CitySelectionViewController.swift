//
//  CitySelectionViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

class CitySelectionViewController: UIViewController {
  // Object Connections
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var searchCityTextField: UITextField!
  @IBOutlet private weak var indicatorView: UIView!
  @IBOutlet private weak var cityTableView: UITableView!
  @IBOutlet private weak var noResultView: UIView!
  @IBOutlet private weak var noResultImage: UIImageView!
  @IBOutlet private weak var noResultTitleLabel: UILabel!
  @IBOutlet private weak var noResultSubtitleLabel: UILabel!
  
  private var viewModel = CitySelectionViewModel()
  private var tableViewHelper: CitySelectionTableViewHelper!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCustomSearchTextField()
    setupUI()
    localization()
    setupController()
  }
  /// Setup UI Elements
  func setupUI(){
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    searchCityTextField.textColor = Themes.colorSolidWhite
    searchCityTextField.font = Themes.fontRegularSubtitle
    indicatorView.backgroundColor = Themes.colorGrayScale
    noResultTitleLabel.textColor = Themes.colorSolidWhite
    noResultTitleLabel.font = Themes.fontExtraBold
    noResultSubtitleLabel.font = Themes.fontRegularSubtitle
    noResultSubtitleLabel.textColor = Themes.colorGrayScale
    noResultImage.image = Themes.noResultImage
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // with this we will disable back button label text
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "cityselectionTitle".localizeString()
    noResultTitleLabel.text = "noCityErrorTitle".localizeString()
    noResultSubtitleLabel.text = "noCityErrorSubTitle".localizeString()
  }
  
  func setupCustomSearchTextField() {
    searchCityTextField.addTarget(self, action: #selector(filterTextEntered), for: .editingChanged) // add and observer for our custom searchBar
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
  /// This function setup vm and tableviewHelper and handle their closures
  func setupController(){
    tableViewHelper.delegate = self
    tableViewHelper = .init(with: cityTableView, vm: viewModel)
    viewModel.fetchCities()
    viewModel.onCitiesChanged = { [weak self] cities in
      self?.cityTableView.isHidden = false // show tableview
      self?.noResultView.isHidden = true // hide no result view
      self?.searchCityTextField.layer.borderColor = Themes.colorGrayScale.cgColor // border color for the textfield
      self?.tableViewHelper.setItems(cities)
    }
    viewModel.onCitiesFiltered = { [weak self] filteredCities in
      self?.cityTableView.isHidden = false // show tableview
      self?.noResultView.isHidden = true // hide no result view
      if filteredCities.count == 0{
        self?.searchCityTextField.layer.borderColor = Themes.colorSecurity.cgColor// border color for the textfield
        self?.cityTableView.isHidden = true // show tableview
        self?.noResultView.isHidden = false // hide no result view
      }else {
        self?.searchCityTextField.layer.borderColor = Themes.colorSelectedGreen.cgColor// border color for the textfield
      }
      self?.tableViewHelper.setItems(filteredCities) // set our tableview's items
      
    }
    viewModel.onCitiesError = { [weak self] receivedError in
      // show received error custom error page
    }
  }
  
  @objc
  func filterTextEntered(textfield: UITextField) {
    viewModel.filterTextValueEntered(textfield.text!) // call viewmodel Filter function
  }
  
  @objc
  func clearTextField() {
    viewModel.resetCities() // reset the values of the our table view
    searchCityTextField.text = "" // set our custom searchText' text empty
    searchCityTextField.layer.borderColor = Themes.colorGrayScale.cgColor // border color for the textfield
  }
  
}
// MARK - CitySelectionProtocol
extension CitySelectionViewController: CitySelectionProtocol {
  func didCitySelected(_ vc: UIViewController) {
    self.navigationController?.pushViewController(vc, animated: true) // PUSH The vc that has been sent from delegate selected city
  }
}
