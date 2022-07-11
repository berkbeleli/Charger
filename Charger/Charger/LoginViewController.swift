//
//  ViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-11.
//

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var loginNoteLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupUI()
  }
  
  func setupUI() {
    self.navigationItem.title = "loginTitle".localizeString()
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    welcomeLabel.attributedText = "welcome".localizeString().withBoldText(text: "loginBoldText".localizeString(),font: Themes.fontRegularHeader)
    welcomeLabel.textColor = Themes.colorSolidWhite
    
    loginNoteLabel.text = "loginNote".localizeString()
    loginNoteLabel.font = Themes.fontRegularSubtitle
    loginNoteLabel.textColor = Themes.colorGrayScale
  }


}

