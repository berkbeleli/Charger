//
//  TimeSelectionTableViewHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

protocol TimeSelectionProtocol: AnyObject {
  func didTimeSelected() // if a time value selected we will let the vc know about it
}

class TimeSelectionTableViewHelper: NSObject {
  weak var delegate: TimeSelectionProtocol?
  private var allTimes: SelectTimeViewModel?
  weak var vm: DateTimeViewModel?
  weak var tableViewFirst: UITableView?
  weak var tableViewSecond: UITableView?
  weak var tableViewThird: UITableView?
  var numberOfSockets: Int? // according to that we will arrange the tableview!s items
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
    registerCells() // register cell all of the tableviews
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
    numberOfSockets = vm?.getNumberOfSockets() // get the number of the sockets from the vm
  }
  
  /// it will deselect all of the selected cells when another cell selected
  func deselectAllCells() {
    for i in 0..<(numberOfSockets ?? 1) {
      for j in 0..<(allTimes?.sockets![i].day?.timeSlots?.count ?? 0) {
        allTimes?.sockets![i].day?.timeSlots![j].isSocketSelected = false // set allItems unselected
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
    
    allTimes?.sockets![tableNumber].day?.timeSlots![indexPath.row].isSocketSelected = true // after setting the socketSelection variable we will reload all of the TableViews
    tableViewFirst?.reloadData()
    tableViewSecond?.reloadData()
    tableViewThird?.reloadData()
    
    vm?.createAppointmentDatas(allTimes: allTimes!, tableNumber: tableNumber, selectedRow: indexPath.row) // let the vm know now it can create a appointmentData variable
    
    self.delegate?.didTimeSelected() // call delegation func
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
      // according to table view we will set the cell tableview
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
    return UITableViewCell() // this line will never work it is redundant it is just here to confirm func requirement
  }
}
