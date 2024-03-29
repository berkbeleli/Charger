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
    emailTextField.keyboardType = .emailAddress // make keyboard type email
    emailTextField.delegate = self
    loginButton.tintColor = Themes.colorDark
    loginButton.backgroundColor = Themes.colorSolidWhite
    loginButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    loginButton.titleLabel?.font = Themes.fontRegularSubtitle
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
    viewModel.requestLocation()
    viewModel.requestNotificationPermission()
    viewModel.onLoginRequested = {[weak self] result in // check the result of login request
      if result == "SUCCESS" {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentsView")
        self?.navigationController?.pushViewController(vc, animated: true)
      }else {
        // show error popup here
        self?.openErrorPopUp(error: result)
      }
    }
    
  }
  
  func openErrorPopUp(error: String) {
    let popvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopupViewController // instantiate custom popup view
    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.addChild(popvc)
    popvc.view.frame = UIScreen.main.bounds
    UIApplication.shared.windows.last!.addSubview(popvc.view)
    // if we receive a server error
    popvc.setupObjects(
      title: "receivedServerErrorTitle".localizeString(),
      subtitle: error.localizeString(),
      confirmButtonLabel:  "receivedServerErrorButtonTitle".localizeString(),
      cancelButtonLabel: "zero".localizeString(),hideSecondButton: true)
    popvc.didMove(toParent: self)
  }
  
  @IBAction func loginButtonPressed(_ sender: UIButton) {
    viewModel.loginRequest(email: emailTextField.text ?? "empty mail")
  }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  // With this extension when we  pressed ok button on keyboard it will be dismissed
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

