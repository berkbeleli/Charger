//
//  ViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-11.
//

import UIKit

class LoginViewController: UIViewController {
  // Object Connections
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var welcomeLabel: UILabel!
  @IBOutlet private weak var loginNoteLabel: UILabel!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var loginButton: UIButton!
  
  private var viewModel = LoginViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupUI()
    localization()
    setupVM()
  }
  /// Setup UI Elements
  func setupUI() {
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    welcomeLabel.textColor = Themes.colorSolidWhite
    loginNoteLabel.font = Themes.fontRegularSubtitle
    loginNoteLabel.textColor = Themes.colorGrayScale
    emailTextField.backgroundColor = .clear
    emailTextField.textColor = Themes.colorSolidWhite
    emailTextField.font = Themes.fontRegularSubtitle
    emailTextField.useUnderline() // make email text underlined
    loginButton.tintColor = Themes.colorDark
    loginButton.backgroundColor = Themes.colorSolidWhite
    loginButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
  }
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "loginTitle".localizeString()
    welcomeLabel.attributedText = "welcome".localizeString().withBoldText(text: "loginBoldText".localizeString(),font: Themes.fontRegularHeader) // set welcome label's Brand side bold
    loginNoteLabel.text = "loginNote".localizeString()
    emailTextField.attributedPlaceholder = NSAttributedString(
        string:  "loginTxtPlaceHolder".localizeString(),
        attributes: [NSAttributedString.Key.foregroundColor: Themes.colorGrayScale]
    )  // set textField placeholder color
    loginButton.setTitle("loginButton".localizeString(), for: .normal)
  }
  
  func setupVM() {
    viewModel.onLoginRequested = { result in
      
      if result == "SUCCESS" {
        print("Show next page")
      }else {
        // show error popup here
        print(result)
      }
      
    }
    
  }

  @IBAction func loginButtonPressed(_ sender: UIButton) {
    viewModel.loginRequest(email: "trylogg@mymail.com")
  }
  
  
}

