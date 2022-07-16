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
  @IBOutlet private weak var infoBackgroundView: UIView!
  @IBOutlet private weak var emailTitleLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var deviceUdIdTitleLabel: UILabel!
  @IBOutlet private weak var deviceUdIdLabel: UILabel!
  @IBOutlet private weak var logoutButton: UIButton!
  
  private var viewModel = ProfileViewModel()
  override func viewDidLoad() {
        super.viewDidLoad()
    setupUI()
    localization()
    setupVM()
    }
  
  /// Setup UI Elements
  func setupUI() {
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    infoBackgroundView.backgroundColor = Themes.colorCharcoal
    infoBackgroundView.layer.cornerRadius = ObjectConstants.viewBorders
    emailLabel.textColor = Themes.colorSolidWhite
    emailLabel.font = Themes.fontBold
    emailTitleLabel.font = Themes.fontRegularSubtitle
    emailTitleLabel.textColor = Themes.colorGrayScale
    deviceUdIdLabel.textColor = Themes.colorSolidWhite
    deviceUdIdLabel.font = Themes.fontBold
    deviceUdIdTitleLabel.font = Themes.fontRegularSubtitle
    deviceUdIdTitleLabel.textColor = Themes.colorGrayScale
    logoutButton.tintColor = Themes.colorDark
    logoutButton.backgroundColor = Themes.colorSolidWhite
    logoutButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    logoutButton.titleLabel?.font = Themes.fontRegularSubtitle
    profileBadgeImage.image = Themes.profileBadgeImage
    emailLabel.text = User.user?.email! // set email label to our user email
    deviceUdIdLabel.text = AppConstants.deviceUDID // set Device Id to our device Id constant value
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self // allow swipe to back page
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "profileTitle".localizeString() // set nav bar title
    emailTitleLabel.text = "email".localizeString()
    deviceUdIdTitleLabel.text = "deviceID".localizeString()
    logoutButton.setTitle("logoutButton".localizeString(), for: .normal)
  }
  
  func setupVM() {
    viewModel.onLogoutRequested = {[weak self]  result in // check the result of login request
      if result == "SUCCESS" {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navController")
        vc.modalPresentationStyle = .fullScreen
        self?.present(vc, animated: true)
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

  @IBAction func logOutPressed(_ sender: UIButton) {
    viewModel.logOutRequest() // request logout from our vm
  }
}
//MARK: - UIGestureRecognizerDelegate
extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // allow slide to back page feature
    }
}
