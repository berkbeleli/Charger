//
//  CitySelectionTableViewHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

protocol CitySelectionProtocol: AnyObject {
  func didCitySelected(_ vc: UIViewController)
}

class CitySelectionTableViewHelper: NSObject {
  weak var delegate: CitySelectionProtocol?
  private var allCities: [LetterCities] = []
  weak var vm: CitySelectionViewModel?
  weak var tableView: UITableView?
  
  init(with tableView: UITableView, vm: CitySelectionViewModel){
    super.init()
    self.tableView = tableView
    self.vm = vm
    self.tableView?.delegate = self // get tableview's delegations
    self.tableView?.dataSource = self
    registerCell()
  }
  /// Register custom cell to our tableView
  func registerCell(){
    tableView?.register(.init(nibName: "CustomCityTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCityTableViewCell")
  }
  /// This function set the table view items and reload the table view
  func setItems(_ items: [LetterCities]) {
    self.allCities = items
    tableView?.reloadData()
  }
}
//MARK: - UITableViewDelegate
extension CitySelectionTableViewHelper: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // city selection
    let rowItem = allCities[indexPath.row]
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "")
    self.delegate?.didCitySelected(vc)
  }
}

//MARK: - UITableViewDataSource
extension CitySelectionTableViewHelper: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    allCities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCityTableViewCell") as! CustomCityTableViewCell
    let rowItem = allCities[indexPath.row]
    let cityText = rowItem.city?.withBoldText(text: rowItem.boldString!, font: Themes.fontRegularSubtitle)
    cell.cityNameLabel.attributedText = cityText
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    return cell
  }
}
