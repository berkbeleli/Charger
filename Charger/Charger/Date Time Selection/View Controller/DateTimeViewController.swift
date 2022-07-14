//
//  DateTimeViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import UIKit

class DateTimeViewController: UIViewController {
 // object connections
  @IBOutlet private weak var statusBarBackgroundView: UIView!
  @IBOutlet private weak var appointmentTimeHeadLabel: UILabel!
  @IBOutlet private weak var appointmentSelectorLabel: UILabel!
  @IBOutlet private weak var socketFirstHolderView: UIStackView!
  @IBOutlet private weak var socketFirstHeaderLabel: UILabel!
  @IBOutlet private weak var socketFirstTypeLabel: UILabel!
  @IBOutlet private weak var socketFirstTableView: UITableView!
  @IBOutlet private weak var socketFirstTableeviewWidth: NSLayoutConstraint!
  @IBOutlet private weak var socketSecondHolderView: UIStackView!
  @IBOutlet private weak var socketSecondHeaderLabel: UILabel!
  @IBOutlet private weak var socketSecondTypeLabel: UILabel!
  @IBOutlet private weak var socketSecondTableView: UITableView!
  @IBOutlet private weak var socketSecondTableeviewWidth: NSLayoutConstraint!
  @IBOutlet private weak var socketThirdHolderView: UIStackView!
  @IBOutlet private weak var socketThirdHeaderLabel: UILabel!
  @IBOutlet private weak var socketThirdTypeLabel: UILabel!
  @IBOutlet private weak var socketThirdTableView: UITableView!
  @IBOutlet private weak var socketThirdTableeViewWidth: NSLayoutConstraint!
  @IBOutlet private weak var confirmTimeButton: UIButton!
  // we will receive this datas from the station view
  var stationId: Int?
  var stationName: String?
  var distance: String?
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    self.navigationItem.setSubTitle("timeTitle".localizeString(), subtitle: "HALLOOO")
    }
    


  
  @IBAction func confirmTimePressed(_ sender: UIButton) {
  }
  

}
