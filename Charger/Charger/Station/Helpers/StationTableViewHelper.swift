//
//  StationTableViewHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import UIKit

protocol StationSelectionProtocol: AnyObject {
  func didStationSelected(_ vc: UIViewController)
}

class StationTableViewHelper: NSObject {
  weak var delegate: StationSelectionProtocol?
  private var allStations: [StationViewViewModel] = []
  weak var vm: StationViewModel?
  weak var tableView: UITableView?
  private var shouldAnimate: Bool = true // with tihs one we will check if there is an animation or not
  
  init(with tableView: UITableView, vm: StationViewModel){
    super.init()
    self.tableView = tableView
    self.vm = vm
    self.tableView?.delegate = self // get tableview's delegations
    self.tableView?.dataSource = self
    registerCell()
  }
  /// Register custom cell to our tableView
  func registerCell(){
    tableView?.register(.init(nibName: "StationTableViewCell", bundle: nil), forCellReuseIdentifier: "StationTableViewCell")
  }
  /// This function set the table view items and reload the table view
  func setItems(_ items: [StationViewViewModel]) {
    shouldAnimate = false
    self.allStations = items
    tableView?.reloadData()
  }
}
//MARK: - UITableViewDelegate
extension StationTableViewHelper: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // city selection
    let rowItem = allStations[indexPath.row]
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "")

    self.delegate?.didStationSelected(vc)
  }
}

//MARK: - UITableViewDataSource
extension StationTableViewHelper: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shouldAnimate ? 10 : allStations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell") as! StationTableViewCell
    
    if shouldAnimate { // check if the animation requested
      cell.startAnimatedSkeletonView() // start the animation
      cell.stationNameLabel.text = "" // there is a small delay before the view appears before them remove the texts
      cell.availableSocketLabel.text = ""
      cell.distanceLabel.text = ""
      cell.workingHours.text = ""
    }else {
      cell.stopAnimatedSkeletonView()
      let rowItem = allStations[indexPath.row]
      cell.chargeTypeImage.image = rowItem.imageType
      cell.stationNameLabel.text = rowItem.stationName
      cell.availableSocketLabel.text = rowItem.availableSocket
      cell.distanceLabel.text = rowItem.distance ?? ""
      cell.workingHours.text = rowItem.workingHours! + " " + "time".localizeString()
    }
    
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    return cell
  }
}



