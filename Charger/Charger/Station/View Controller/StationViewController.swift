//
//  StationViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

class StationViewController: UIViewController {
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var searchStationTextField: UITextField!
  @IBOutlet private weak var filterCollectionView: UICollectionView!
  @IBOutlet private weak var resultLabel: UILabel!
  @IBOutlet private weak var stationsTableView: UITableView!
  @IBOutlet private weak var resultView: UIStackView!
  @IBOutlet private weak var noResultView: UIView!
  @IBOutlet private weak var noResultImage: UIImageView!
  @IBOutlet private weak var noResultTitle: UILabel!
  @IBOutlet private weak var noResultSubtitle: UILabel!
  private var viewModel = StationViewModel()
  private var tableViewHelper: StationTableViewHelper!
  private var collectionViewHelper: StationCollectionViewHelper!
  var cityName: String?
  var filterValues: FilterModel? // it will hold the filter Values
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupCustomSearchTextField()
    localization()
  }
  override func viewWillAppear(_ animated: Bool) {
    if filterValues == nil {
      setupController()
      tableViewHelper.startGradientAnimation()
    }
  }
  
  /// Setup UI Elements
  func setupUI(){
    filterCollectionView.isHidden = true
    resultLabel.isHidden = true
    resultLabel.textColor = Themes.colorSolidWhite
    resultLabel.font = Themes.fontRegularSubtitle
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    searchStationTextField.textColor = Themes.colorSolidWhite
    searchStationTextField.font = Themes.fontRegularSubtitle
    noResultTitle.textColor = Themes.colorSolidWhite
    noResultTitle.font = Themes.fontExtraBold
    noResultSubtitle.font = Themes.fontRegularSubtitle
    noResultSubtitle.textColor = Themes.colorGrayScale
    noResultImage.image = Themes.noResultImage
    noResultView.isHidden = true
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // with this we will disable back button label text
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease")?.withTintColor(Themes.colorSolidWhite), style: .plain, target: self, action: #selector(filterPageOpen)) // Create open Filter Page Button
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self // allow swipe to back page
    searchStationTextField.delegate = self
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "stationselectionTitle".localizeString()
    noResultTitle.text = "noCityErrorTitle".localizeString()
    noResultSubtitle.text = "noCityErrorSubTitle".localizeString()
  }
  
  func setupCustomSearchTextField() {
    searchStationTextField.addTarget(self, action: #selector(filterTextEntered), for: .editingChanged) // add and observer for our custom searchBar
    searchStationTextField.layer.cornerRadius = ObjectConstants.searchTextFiledBorderRadius
    searchStationTextField.backgroundColor = Themes.colorDark
    searchStationTextField.clipsToBounds = true // to make text field radiues rounded
    searchStationTextField.layer.borderWidth = 2 // border width for the textfield
    searchStationTextField.layer.borderColor = Themes.colorGrayScale.cgColor // border color for the textfield
    searchStationTextField.attributedPlaceholder = NSAttributedString(
      string:  "searchStationPlaceHolder".localizeString(),
      attributes: [NSAttributedString.Key.foregroundColor: Themes.colorGrayScale]
    )  // set textField placeholder color
    searchStationTextField.setIcon(UIImage(systemName: "magnifyingglass")!) // set left view of the text field
    let imageView = UIImageView(image: UIImage(systemName: "xmark.circle.fill")) // set right cancel button image
    imageView.tintColor = Themes.colorGrayScale // set cancel button color
    imageView.frame = CGRect(x: 0, y: 0, width: 25 , height: 25)
    let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
    paddingView.addSubview(imageView)
    imageView.center = CGPoint(x: paddingView.frame.size.width  / 2,
                               y: paddingView.frame.size.height / 2)
    searchStationTextField.rightViewMode = .whileEditing // make cancel button visible when editing the text filed
    searchStationTextField.rightView = paddingView
    imageView.isUserInteractionEnabled = true
    let cancelButton = UITapGestureRecognizer(target: self, action: #selector(clearTextField)) // add gesture func to our cancel button image
    imageView.addGestureRecognizer(cancelButton)// add gesture to our cancel button image
  }
  
  func setupController() {
    viewModel.fetchStations(cityName: cityName ?? "Unknown City")
    tableViewHelper = .init(with: stationsTableView, vm: viewModel)
    tableViewHelper.startGradientAnimation()
    tableViewHelper.delegate = self
    viewModel.onStationsChanged = {[weak self] stations in
      if stations.count == 0{
        self?.resultView.isHidden = true // show tableview
        self?.noResultView.isHidden = false // hide no result view
      }else {
        self?.resultView.isHidden = false // show tableview
        self?.noResultView.isHidden = true // hide no result view
      }
      
      self?.resultLabel.isHidden = false
      self?.searchStationTextField.layer.borderColor = Themes.colorGrayScale.cgColor // border color for the textfield
      let stringResult = String(format: NSLocalizedString("City: %@ Count: %@", comment: ""), self?.cityName! as! NSString, "\(stations.count)" as! NSString) // localize string
      self?.resultLabel.attributedText = stringResult.withBoldText(text: self?.cityName! ?? "Unknown City", font: Themes.fontRegularSubtitle) // make city label bold
      self?.tableViewHelper.setItems(stations)
    }
    
    viewModel.onStationsFiltered =  {[weak self] filteredStations in
      if filteredStations.count == 0{
        self?.resultView.isHidden = true // show tableview
        self?.noResultView.isHidden = false // hide no result view
        self?.searchStationTextField.layer.borderColor = Themes.colorSecurity.cgColor// border color for the textfield
        let stringResult = String(format: NSLocalizedString("City: %@ Count: %@", comment: ""), self?.cityName! as! NSString, "0" as! NSString)// localize string
        self?.resultLabel.attributedText = stringResult.withBoldText(text: self?.cityName! ?? "Unknown City", font: Themes.fontRegularSubtitle)// make city label bold
      }else {
        self?.resultView.isHidden = false // show tableview
        self?.noResultView.isHidden = true // hide no result view
        self?.searchStationTextField.layer.borderColor = Themes.colorSelectedGreen.cgColor// border color for the textfield
        let stringResult = String(format: NSLocalizedString("City: %@ Count: %@", comment: ""), self?.cityName! as! NSString, "\(filteredStations.count)" as! NSString)// localize string
        self?.resultLabel.attributedText = stringResult.withBoldText(text: self?.cityName! ?? "Unknown City", font: Themes.fontRegularSubtitle)// make city label bold
      }
      self?.tableViewHelper.setItems(filteredStations) // set our tableview's items
    }
    
    viewModel.onStationsError = { [weak self] receivedError in
      // show received error custom error page
      self?.openErrorPopUp(error: receivedError)
    }
    
    collectionViewHelper = .init(with: filterCollectionView, vm: viewModel)
    viewModel.onFiltersConverted = {[weak self] filters in
      if filters.count == 0 { // if there is no item
        self?.filterCollectionView.isHidden = true // hide the collection view
        self?.navigationItem.rightBarButtonItem?.tintColor = Themes.colorSolidWhite // make the color default
        self?.viewModel.filteredStations()
      }else{
        self?.collectionViewHelper.setItems(filters) // if there is any filter item send them to our helper class
      }
    }
  }
  
  func openErrorPopUp(error: String) {
    let popvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopupViewController // instantiate custom popup view
    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.addChild(popvc)
    popvc.view.frame = UIScreen.main.bounds
    UIApplication.shared.windows.last!.addSubview(popvc.view)
    // if we receive a server error
    popvc.setupObjects(
      title: "receivedServerErrorTitle".localizeString(),
      subtitle: error.localizeString(),
      confirmButtonLabel:  "receivedServerErrorButtonTitle".localizeString(),
      cancelButtonLabel: "zero".localizeString(),hideSecondButton: true)
    popvc.didMove(toParent: self)
  }
  

  
  @objc
  func filterTextEntered(textfield: UITextField) {
    viewModel.filterTextValueEntered(textfield.text!) // call viewmodel Filter function
  }
  
  @objc
  func clearTextField() {
    viewModel.resetStations() // reset the values of the our table view
    searchStationTextField.text = "" // set our custom searchText' text empty
    searchStationTextField.layer.borderColor = Themes.colorGrayScale.cgColor // border color for the textfield
  }
  
  @objc
  func filterPageOpen() {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterStationsView") as! FilterStationsViewController
    vc.filterValues = viewModel.filterValuesRequest()
    self.navigationController?.pushViewController(vc, animated: true)
    vc.onfilterChanged = { [weak self] filterValues in
      self?.filterValues = filterValues
      
      if self?.viewModel.checkIfTheFiltersEmpty(filterValues: filterValues) ?? false { // checks if filters contains any data
        self?.navigationItem.rightBarButtonItem?.tintColor = Themes.colorSelectedGreen // if so make right bar button color green
        self?.filterCollectionView.isHidden = false // show the filter collection view visible
        self?.viewModel.convertReceivedFilters() // convert the received items into string array
        self?.viewModel.filteredStations()
      }else {
        self?.navigationItem.rightBarButtonItem?.tintColor = Themes.colorSolidWhite // if not make it white
        self?.filterCollectionView.isHidden = true // hide the collection view
      }
      
    }
  }
}
// MARK - StationSelectionProtocol
extension StationViewController: StationSelectionProtocol {
  func didStationSelected(_ vc: UIViewController) {
    self.navigationController?.pushViewController(vc, animated: true) // PUSH The vc that has been sent from delegate selected station
  }
}

//MARK: - UIGestureRecognizerDelegate
extension StationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // allow slide to back page feature
    }
}

//MARK: - UITextFieldDelegate
extension StationViewController: UITextFieldDelegate {
  // With this extension when we  pressed ok button on keyboard it will be dismissed
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
