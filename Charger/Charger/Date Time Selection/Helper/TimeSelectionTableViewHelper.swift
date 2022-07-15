//
//  TimeSelectionTableViewHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

protocol TimeSelectionProtocol: AnyObject {
  func didTimeSelected(appointmentDatas: AppointmentDatas)
}

class TimeSelectionTableViewHelper: NSObject {
  weak var delegate: TimeSelectionProtocol?
  private var allTimes: SelectTimeViewModel?
  weak var vm: DateTimeViewModel?
  weak var tableViewFirst: UITableView?
  weak var tableViewSecond: UITableView?
  weak var tableViewThird: UITableView?
  var numberOfSockets: Int?
  init(tableViewFirst: UITableView, tableViewSecond: UITableView, tableViewThird: UITableView, vm: DateTimeViewModel){
    super.init()
    self.tableViewFirst = tableViewFirst
    self.tableViewSecond = tableViewSecond
    self.tableViewThird = tableViewThird
    self.vm = vm
    self.tableViewFirst?.delegate = self // get tableview's delegations
    self.tableViewFirst?.dataSource = self
    self.tableViewSecond?.delegate = self // get tableview's delegations
    self.tableViewSecond?.dataSource = self
    self.tableViewThird?.delegate = self // get tableview's delegations
    self.tableViewThird?.dataSource = self
    registerCells()
  }
  /// Register custom cell to our tableView
  func registerCells(){
    tableViewFirst?.register(.init(nibName: "TimeSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeSelectionTableViewCell")
    tableViewSecond?.register(.init(nibName: "TimeSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeSelectionTableViewCell")
    tableViewThird?.register(.init(nibName: "TimeSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeSelectionTableViewCell")
  }
  /// This function set the table view items and reload the table view
  func setItems(_ items:SelectTimeViewModel) {
    self.allTimes = items
    tableViewFirst?.reloadData()
    tableViewSecond?.reloadData()
    tableViewThird?.reloadData()
    numberOfSockets = vm?.getNumberOfSockets()
  }
  
  /// it will deselect all of the selected cells when another cell selected
  func deselectAllCells() {
    for i in 0..<(numberOfSockets ?? 1) {
      for j in 0..<(allTimes?.sockets![i].day?.timeSlots?.count ?? 0) {
        allTimes?.sockets![i].day?.timeSlots![j].isSocketSelected = false
      }
    }
  }
}
//MARK: - UITableViewDelegate
extension TimeSelectionTableViewHelper: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    deselectAllCells()
    // time selection
    var tableNumber = 0
    if tableView == tableViewFirst { // checks which tableview's data selected
      tableNumber = 0
    }else {
      tableView == tableViewSecond ? (tableNumber = 1) : (tableNumber = 2)
    }
    
    allTimes?.sockets![tableNumber].day?.timeSlots![indexPath.row].isSocketSelected = true
    tableViewFirst?.reloadData()
    tableViewSecond?.reloadData()
    tableViewThird?.reloadData()
    
    var appointmentDatas = vm?.createAppointmentDatas(allTimes: allTimes!, tableNumber: tableNumber, selectedRow: indexPath.row)
    
    self.delegate?.didTimeSelected(appointmentDatas: appointmentDatas!)
  }
}

//MARK: - UITableViewDataSource
extension TimeSelectionTableViewHelper: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    allTimes?.sockets![0].day?.timeSlots?.count ?? 0 // as all the stations will have the same amount of the slots return the first one's count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var tableNumber = 0
    if tableView == tableViewFirst { // check the tableview type
      tableNumber = 0
    }else {
      tableView == tableViewSecond ? (tableNumber = 1) : (tableNumber = 2)
    }
    
    if tableNumber <= ((numberOfSockets! - 1)) {
      
      var cell = tableViewFirst?.dequeueReusableCell(withIdentifier: "TimeSelectionTableViewCell") as! TimeSelectionTableViewCell
      if tableNumber == 1 {
        cell = tableViewSecond?.dequeueReusableCell(withIdentifier: "TimeSelectionTableViewCell") as! TimeSelectionTableViewCell
      }else {
        cell = tableViewThird?.dequeueReusableCell(withIdentifier: "TimeSelectionTableViewCell") as! TimeSelectionTableViewCell
      }
      
      let rowItem = allTimes?.sockets![tableNumber].day?.timeSlots![indexPath.row]
      cell.timeLabel.text = rowItem?.slot
      (rowItem?.isSocketSelected)! ? cell.selectCell() : cell.deSelectCell()
      (rowItem?.isOccupied)! ? cell.disableCell() : cell.normalCell()
      (rowItem?.isOccupied)! ? (cell.isUserInteractionEnabled = false) : (cell.isUserInteractionEnabled = true)
      cell.backgroundColor = .clear
      cell.selectionStyle = .none
      return cell
      
    }
    return UITableViewCell()
  }
}
