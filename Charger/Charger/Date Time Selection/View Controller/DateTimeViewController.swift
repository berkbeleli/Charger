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
  @IBOutlet private weak var socket1HolderView: UIStackView!
  @IBOutlet private weak var socket1HeaderLabel: UILabel!
  @IBOutlet private weak var socket1TypeLabel: UILabel!
  @IBOutlet private weak var socket1TableView: UITableView!
  @IBOutlet private weak var socket1TableeviewWidth: NSLayoutConstraint!
  @IBOutlet private weak var socket2HolderView: UIStackView!
  @IBOutlet private weak var socket2HeaderLabel: UILabel!
  @IBOutlet private weak var socket2TypeLabel: UILabel!
  @IBOutlet private weak var socket2TableView: UITableView!
  @IBOutlet private weak var socket2TableeviewWidth: NSLayoutConstraint!
  @IBOutlet private weak var socket3HolderView: UIStackView!
  @IBOutlet private weak var socket3HeaderLabel: UILabel!
  @IBOutlet private weak var socket3TypeLabel: UILabel!
  @IBOutlet private weak var socket3TableView: UITableView!
  @IBOutlet private weak var socket3TableeViewWidth: NSLayoutConstraint!
  @IBOutlet private weak var confirmTimeButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    self.navigationItem.setSubTitle("timeTitle".localizeString(), subtitle: "HALLOOO")
    }
    


  
  @IBAction func confirmTimePressed(_ sender: UIButton) {
  }
  

}
