//
//  AppointmentsTableViewHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-16.
//

import UIKit

protocol AppointmentViewProtocol: AnyObject {
  func didDeletionSelected(appointmentID: String, stationName: String, date: String, time: String)
}

class AppointmentsTableViewHelper: NSObject {
  private var currentAppointments: [AppointmentViewViewModel] = []
  private var pastAppointments: [AppointmentViewViewModel] = []
  weak var vm: AppointmentsViewModel?
  weak var tableView: UITableView?
  weak var delegate: AppointmentViewProtocol?
  
  init(with tableView: UITableView, vm: AppointmentsViewModel){ // initialize tableview
    super.init()
    self.tableView = tableView
    self.vm = vm
    self.tableView?.delegate = self // get tableview's delegations
    self.tableView?.dataSource = self
    registerCell()
  }
  /// Register custom cell to our tableView
  func registerCell(){
    tableView?.register(.init(nibName: "AppointmentsTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentsTableViewCell")
  }
  /// This function set the table view items and reload the table view
  func setItems(currentAppointments: [AppointmentViewViewModel], pastAppointments: [AppointmentViewViewModel] ) {
    self.currentAppointments = currentAppointments
    self.pastAppointments = pastAppointments
    tableView?.reloadData()
  }
}
//MARK: - UITableViewDelegate
extension AppointmentsTableViewHelper: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40)) // create a headerview
    
    let label = UILabel()
    label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
    
    if section == 0{
      label.text = "currentAppointmentsTitle".localizeString() // if first section set the title
    }  else if section == 1{
      label.text = "pastAppointmentsTitle".localizeString() // if second second the title
      
    }
    
    if section == 0 && currentAppointments.count == 0 { // if there is not any current appointment hide the header title
      label.isHidden = true
      headerView.isHidden = true
    }
    
    label.font = Themes.fontBoldMakeAppointmentHeader // set label's font
    label.textColor = Themes.colorGrayScale // set label's color
    headerView.addSubview(label)
      return headerView
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 && currentAppointments.count == 0 {
      return CGFloat.leastNonzeroMagnitude // if there is no current appointment make the height sth but zero
    }
    return 40 // height value
  }
}

//MARK: - UITableViewDataSource
extension AppointmentsTableViewHelper: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 { // set the number of the items for each section
      return currentAppointments.count
    }else {
      return pastAppointments.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentsTableViewCell") as! AppointmentsTableViewCell
    
    if indexPath.section == 0 {
      let rowItem = currentAppointments[indexPath.row] // set table view item cells
      cell.appointmentChargeTypeImage.image = rowItem.imageType
      cell.stationNameLabel.text = rowItem.stationName!
      cell.appointmentTimeLabel.text = rowItem.showingTime
      cell.socketNumberLabel.text = "\(rowItem.socket?.socketId ?? 0)"
      cell.deleteAppointmentButton.isHidden = false
      rowItem.notificationTime != "" ? (cell.outsourcePowerLabel.isHidden = true ) : (cell.outsourcePowerLabel.isHidden = false ) // if there is no notification time show other info
      rowItem.notificationTime != "" ? (cell.notificationTimeView.isHidden = false ) : (cell.notificationTimeView.isHidden = true )
      cell.notificationTimeLabel.text = (rowItem.notificationTime?.localizeString())! + " " + "beforetime".localizeString() // set notification time label text
      cell.outsourcePowerLabel.text = rowItem.outpower
      cell.chargeAndSocketTypeLabel.text = "\(rowItem.socket?.chargeType ?? "AC")" + " • " +  "\(rowItem.socket?.socketType ?? "AC")"
    
      cell.deleteAppointment = {[weak self] _ in // handle delete button action with delegation
        self?.delegate?.didDeletionSelected(appointmentID: rowItem.appointmentId!, stationName: rowItem.stationName!,date: rowItem.showAlertTime! ,time: rowItem.time!)
      }
    }else { // handle past appointments
      let rowItem = pastAppointments[indexPath.row]
      cell.appointmentChargeTypeImage.image = rowItem.imageType
      cell.stationNameLabel.text = rowItem.stationName!
      cell.notificationTimeView.isHidden = true
      cell.outsourcePowerLabel.isHidden = false
      cell.deleteAppointmentButton.isHidden = true
      cell.appointmentTimeLabel.text = rowItem.showingTime
      cell.socketNumberLabel.text = "\(rowItem.socket?.socketId ?? 0)"
      cell.outsourcePowerLabel.text = rowItem.outpower
      cell.chargeAndSocketTypeLabel.text = "\(rowItem.socket?.chargeType ?? "AC")" + " • " +  "\(rowItem.socket?.socketType ?? "AC")"
    }
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    return cell
  }
}



