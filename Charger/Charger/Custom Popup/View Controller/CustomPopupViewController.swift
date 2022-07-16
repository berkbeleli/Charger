//
//  CustomPopupViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class CustomPopupViewController: UIViewController {
  var confirmPressed: ((String) -> ())?
  var secondActionPressed: ((String) -> ())?
  // object connections
  @IBOutlet private weak var popUpbgView: UIView!
  @IBOutlet private weak var popUpAlertImage: UIImageView!
  @IBOutlet private weak var alertTitleLabel: UILabel!
  @IBOutlet private weak var alertSubtitleLabel: UILabel!
  @IBOutlet private weak var actionButton: UIButton!
  @IBOutlet private weak var secondActionButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    showAnimate()
    setupUI()
  }
  /// Using this function we can set the items values
  func setupObjects(title: String, subtitle: String, confirmButtonLabel: String, cancelButtonLabel: String, hideSecondButton: Bool? = false) {
    alertTitleLabel.text = title
    alertSubtitleLabel.text = subtitle
    actionButton.setTitle(confirmButtonLabel, for: .normal)
    secondActionButton.setTitle(cancelButtonLabel, for: .normal)
    secondActionButton.isHidden = hideSecondButton! // if we do not need second button we will hide it
  }
  // setup UIView
  func setupUI() {
    popUpbgView.backgroundColor = Themes.colorCharcoal
    popUpbgView.layer.cornerRadius = ObjectConstants.viewBorders
    popUpAlertImage.image = Themes.alertImage
    alertTitleLabel.font = Themes.fontBold
    alertTitleLabel.textColor = Themes.colorSolidWhite
    alertSubtitleLabel.font = Themes.fontRegularSubtitle
    alertSubtitleLabel.textColor = Themes.colorGrayScale
    actionButton.backgroundColor = Themes.colorSolidWhite  // setup confirm button
    actionButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    actionButton.titleLabel?.font = Themes.fontRegularSubtitle
    actionButton.tintColor = Themes.colorDark
    secondActionButton.backgroundColor = .clear  // setup confirm button
    secondActionButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    secondActionButton.titleLabel?.font = Themes.fontRegularSubtitle
    secondActionButton.tintColor = Themes.colorSolidWhite
    secondActionButton.layer.borderWidth = 1
    secondActionButton.layer.borderColor = Themes.colorGrayScale.cgColor
  }
  /// show animation as the view appears
  func showAnimate()
  {
    self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    self.view.alpha = 0.0
    UIView.animate(withDuration: 0.25, animations: {
      self.view.alpha = 1.0
      self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    })
  }
  /// remove the view with animation
  func removeAnimate()
  {
    UIView.animate(withDuration: 0.25, animations: {
      self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      self.view.alpha = 0.0
    }, completion: {(finished : Bool) in
      if(finished)
      {
        self.dismiss(animated: true)
      }
    })
  }
  
  
  @IBAction func actionButtonPressed(_ sender: UIButton) {
    self.removeFromParent()
    self.confirmPressed?("CONFIRMED")
    removeAnimate()
  }
  
  @IBAction func secondActionButtonPressed(_ sender: UIButton) {
    self.removeFromParent()
    self.secondActionPressed?("SECONDACTION")
    removeAnimate()
    self.dismiss(animated: true)
  }
  
}
