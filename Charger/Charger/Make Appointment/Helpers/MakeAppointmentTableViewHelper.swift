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
  
}
//MARK: - UITableViewDelegate
extension MakeAppointmentTableViewHelper: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
    
    let label = UILabel()
    label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
    
    if section == 0 {
      label.text = "stationInfo".localizeString()
      
    }  else if section == 1 {
      label.text = "socketInfos".localizeString()
      
    }else {
      label.text = "appointmentInfos".localizeString()
    }
    label.font = Themes.fontBoldStationSubValues
    label.textColor = Themes.colorGrayScale
    
    headerView.addSubview(label)
    return headerView
    
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
}

//MARK: - UITableViewDataSource
extension MakeAppointmentTableViewHelper: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 5 }else if section == 1 {
        return 4}else {
          return 5 }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellAll = tableView.dequeueReusableCell(withIdentifier: "OtherDatasTableViewCell") as! OtherDatasTableViewCell
    
    if indexPath.section == 0 {
      if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakeAppAddresssTableViewCell") as! MakeAppAddresssTableViewCell
        cell.addressLabel.text = appointmentValues?.address
        cell.backgroundColor = .clear
        return cell
      }  else if indexPath.row == 1 {

        cellAll.appointmentInfoTypeLabel.text = "workingHours".localizeString()
        cellAll.appointmentType.text = appointmentValues?.workingHours ?? "24" + "time".localizeString()
      }  else if indexPath.row == 2 {

        cellAll.appointmentInfoTypeLabel.text = "distance".localizeString()
        appointmentValues?.distance == "-1" ? (cellAll.isHidden = true) : (cellAll.isHidden = false)
        cellAll.appointmentType.text = appointmentValues?.distance
      }  else if indexPath.row == 3 {
        cellAll.appointmentInfoTypeLabel.text = "stationCode".localizeString()
        cellAll.appointmentType.text = appointmentValues?.stationCode
      }  else if indexPath.row == 4 {
        cellAll.appointmentInfoTypeLabel.text = "services"
        cellAll.appointmentType.text = appointmentValues?.services?.joined(separator: ", ")
      }
      cellAll.backgroundColor = .clear
      return cellAll
    } else if indexPath.section == 1 {
       if indexPath.row == 0 {
         cellAll.appointmentInfoTypeLabel.text = "socketNumber".localizeString()
         cellAll.appointmentType.text = "\(appointmentValues?.socketNumber)"
      }  else if indexPath.row == 1 {
        cellAll.appointmentInfoTypeLabel.text = "deviceType".localizeString()
        cellAll.appointmentType.text = appointmentValues?.deviceType
      }  else if indexPath.row == 2 {
        cellAll.appointmentInfoTypeLabel.text = "socketType".localizeString()
        cellAll.appointmentType.text = appointmentValues?.socketType
      }  else if indexPath.row == 3 {
        cellAll.appointmentInfoTypeLabel.text = "outpower".localizeString()
        cellAll.appointmentType.text = appointmentValues?.outsorcepower
      }
      cellAll.backgroundColor = .clear
      return cellAll

    }else {
      if indexPath.row == 0 {

        cellAll.appointmentInfoTypeLabel.text = "date".localizeString()
        cellAll.appointmentType.text = appointmentValues?.dateView
     }  else if indexPath.row == 1 {

       cellAll.appointmentInfoTypeLabel.text = "time".localizeString()
       cellAll.appointmentType.text = appointmentValues?.time
     }  else if indexPath.row == 2 {

       cellAll.appointmentInfoTypeLabel.text = "appointmentDuration".localizeString()
       cellAll.appointmentType.text = "1" + "time".localizeString()
     }  else if indexPath.row == 3 {

       let cell = tableView.dequeueReusableCell(withIdentifier: "GetNotifiedTableViewCell") as! GetNotifiedTableViewCell
       
       (vm?.getNotified)! ? cell.setSwitchOn() : cell.setSwitchOff()
       cell.togglerChanged = { value in
         if value == "ON" {
           self.vm?.getNotified = true
           self.tableView?.reloadData()
         }else {
           self.vm?.getNotified = false
           self.tableView?.reloadData()
         }
       }
       cell.backgroundColor = .clear
       return cell
     } else{

       
       let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTimeTableViewCell") as! NotificationTimeTableViewCell
       
       cell.notificationTimeLabel.text = notificationTime ?? "5 Minutes ago"
       
       (cell.pickerSelectorView as? PickerView)?.delegate = self
       
       cell.backgroundColor = .clear
     

       if showNotificationTimes {
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
