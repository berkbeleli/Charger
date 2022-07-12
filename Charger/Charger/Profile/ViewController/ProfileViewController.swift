//
//  ProfileViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit

class ProfileViewController: UIViewController {
  // Object Connections
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var profileBadgeImage: UIImageView!
  @IBOutlet private weak var ınfoBackgroundView: UIView!
  @IBOutlet private weak var emailTitleLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var deviceUdIdTitleLabel: UILabel!
  @IBOutlet private weak var deviceUdIdLabel: UILabel!
  @IBOutlet private weak var logoutButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func logOutPressed(_ sender: UIButton) {
  }
  
}
