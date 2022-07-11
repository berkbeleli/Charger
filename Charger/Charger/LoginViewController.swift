//
//  ViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-11.
//

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var welcomeLabel: UILabel!
  @IBOutlet private weak var loginNoteLabel: UILabel!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var loginButton: UIButton!
  
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
    
    
    emailTextField.backgroundColor = .clear
    emailTextField.textColor = Themes.colorSolidWhite
    emailTextField.font = Themes.fontRegularSubtitle
    emailTextField.attributedPlaceholder = NSAttributedString(
        string:  "loginTxtPlaceHolder".localizeString(),
        attributes: [NSAttributedString.Key.foregroundColor: Themes.colorGrayScale]
    )
    emailTextField.useUnderline()
    
    loginButton.setTitle("loginButton".localizeString(), for: .normal)
    loginButton.tintColor = Themes.colorDark
    loginButton.backgroundColor = Themes.colorSolidWhite
    loginButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    
  }

  @IBAction func loginButtonPressed(_ sender: UIButton) {
  }
  
  
}

