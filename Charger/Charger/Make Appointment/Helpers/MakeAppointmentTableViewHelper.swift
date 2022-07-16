//
//  MakeAppointmentTableViewHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class MakeAppointmentTableViewHelper: NSObject {
  private var appointmentValues: AppointmentDatas?
  weak var vm: MakeAppointmentViewModel?
  weak var tableView: UITableView?
  
  var numberOfSockets: Int? // according to that we will arrange the tableview!s items
  init(tableView: UITableView, vm: MakeAppointmentViewModel){
    super.init()
    self.tableView = tableView
    self.vm = vm
    self.tableView?.delegate = self // get tableview's delegations
    self.tableView?.dataSource = self
    registerCells() // register cell all of the tableviews
  }
  /// Register custom cell to our tableView
  func registerCells(){
    tableView?.register(.init(nibName: "NotificationTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTimeTableViewCell")
    tableView?.register(.init(nibName: "GetNotifiedTableViewCell", bundle: nil), forCellReuseIdentifier: "GetNotifiedTableViewCell")
    tableView?.register(.init(nibName: "OtherDatasTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherDatasTableViewCell")
    tableView?.register(.init(nibName: "MakeAppAddresssTableViewCell", bundle: nil), forCellReuseIdentifier: "MakeAppAddresssTableViewCell")
  }
  
  /// This function set the table view items and reload the table view
  func setItems(_ items: AppointmentDatas) {
    appointmentValues = items
    tableView?.reloadData()
  }
  
}
//MARK: - UITableViewDelegate
extension MakeAppointmentTableViewHelper: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    // create a header view to hold our header label
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
    let label = UILabel()//  create a custom label
    label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
    if section == 0 {
      label.text = "stationInfo".localizeString() // if first section set the title
    } else if section == 1 {
      label.text = "socketInfos".localizeString() // if second section set the title
    }else {
      label.text = "appointmentInfos".localizeString()  // if third section set the title
    }
    label.font = Themes.fontBoldMakeAppointmentHeader // set label's font
    label.textColor = Themes.colorGrayScale // set label's color
    headerView.addSubview(label) // insert created header label to our header
    return headerView // return header
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40 // header heeight size
  }
}

//MARK: - UITableViewDataSource
extension MakeAppointmentTableViewHelper: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    3 // number of the sections
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 5
    }else if section == 1 {
      return 4
    }else {
      return 5 }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellAll = tableView.dequeueReusableCell(withIdentifier: "OtherDatasTableViewCell") as! OtherDatasTableViewCell // as most of the cell's uses this cell I set it for all
    if indexPath.section == 0 {
      if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakeAppAddresssTableViewCell") as! MakeAppAddresssTableViewCell
        cell.addressLabel.text = appointmentValues?.address //  first item uses address cell
        cell.backgroundColor = .clear
        return cell
      }  else if indexPath.row == 1 {
        cellAll.appointmentInfoTypeLabel.text = "workingHours".localizeString() // set the title
        cellAll.appointmentType.text = (appointmentValues?.workingHours)! + " " + "time".localizeString()
      }  else if indexPath.row == 2 {
        cellAll.appointmentInfoTypeLabel.text = "distance".localizeString() // set the distance title
        appointmentValues?.distance == "-1" ? (cellAll.isHidden = true) : (cellAll.isHidden = false) // if location is not available we will hide this cell
        cellAll.appointmentType.text = appointmentValues?.distance
      }  else if indexPath.row == 3 {
        cellAll.appointmentInfoTypeLabel.text = "stationCode".localizeString() // localzie title
        cellAll.appointmentType.text = appointmentValues?.stationCode
      }  else if indexPath.row == 4 {
        cellAll.appointmentInfoTypeLabel.text = "services".localizeString()  // localzie title
        var services = appointmentValues?.services?.map { $0.localizeString() }
        cellAll.appointmentType.text = services!.joined(separator: ", ")// join array values by ,
      }
      cellAll.backgroundColor = .clear
      return cellAll
    } else if indexPath.section == 1 {
      if indexPath.row == 0 {
        cellAll.appointmentInfoTypeLabel.text = "socketNumber".localizeString()// localzie title
        cellAll.appointmentType.text = "\(appointmentValues?.socketNumber ?? 0)"
      }  else if indexPath.row == 1 {
        cellAll.appointmentInfoTypeLabel.text = "deviceType".localizeString()// localzie title
        cellAll.appointmentType.text = appointmentValues?.deviceType
      }  else if indexPath.row == 2 {
        cellAll.appointmentInfoTypeLabel.text = "socketType".localizeString()// localzie title
        cellAll.appointmentType.text = appointmentValues?.socketType
      }  else if indexPath.row == 3 {
        cellAll.appointmentInfoTypeLabel.text = "outpower".localizeString()// localzie title
        cellAll.appointmentType.text = appointmentValues?.outsorcepower
      }
      cellAll.backgroundColor = .clear
      return cellAll
    }else {
      if indexPath.row == 0 {
        
        cellAll.appointmentInfoTypeLabel.text = "date".localizeString()// localzie title
        cellAll.appointmentType.text = appointmentValues?.dateView
      }  else if indexPath.row == 1 {
        
        cellAll.appointmentInfoTypeLabel.text = "time".localizeString()// localzie title
        cellAll.appointmentType.text = appointmentValues?.time
      }  else if indexPath.row == 2 {
        
        cellAll.appointmentInfoTypeLabel.text = "appointmentDuration".localizeString()// localzie title
        cellAll.appointmentType.text = "1" + " " + "time".localizeString()
      }  else if indexPath.row == 3 {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetNotifiedTableViewCell") as! GetNotifiedTableViewCell
        
        (vm?.getNotified)! ? cell.setSwitchOn() : cell.setSwitchOff() // check the notification is allowed or not we control it as table view as tableview redraw this cell we may lose the state of the switch
        cell.togglerChanged = { value in
          if value == "ON" {
            self.vm?.getNotified = true // set we want to receive notification
            self.tableView?.reloadData()
          }else {
            self.vm?.getNotified = false // set we dont want to receive notificaiton
            self.tableView?.reloadData()
          }
        }
        cell.backgroundColor = .clear
        return cell
      } else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTimeTableViewCell") as! NotificationTimeTableViewCell
        
        cell.notificationTimeLabel.text = (vm!.notificationTime?.localizeString())! + " " + "beforetime".localizeString()
        (cell.notificationTimeBackgroundView as? NotificationTimePickerView)?.delegate = self // get time picker delegation
        cell.backgroundColor = .clear
        if vm?.getNotified ?? false { // if wwe do not want to reeceive notification we will hide this cell
          cell.isHidden = false
        }else {
          cell.isHidden = true
        }
        return cell
      }
      cellAll.backgroundColor = .clear
      return cellAll
      
    }
  }
}
// MARK: - NotificationTimeProtocol
extension MakeAppointmentTableViewHelper: NotificationTimeProtocol {
  func timeChanged(time: String) {
    vm?.notificationTime = time // set the selected notification time
    tableView?.reloadData() // reload the table view
  }
}
