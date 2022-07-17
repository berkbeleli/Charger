//
//  NotifivationTimeTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class NotificationTimeTableViewCell: UITableViewCell {
  //Object connections
  @IBOutlet private(set) weak var notificationTimeBackgroundView: NotificationTimePickerView!
  @IBOutlet private(set) weak var notificationTimeLabel: UILabel!
  @IBOutlet private weak var expandMoreImage: UIImageView!
  @IBOutlet private weak var indicatorView: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

  // setup view
  func setupUI() {
    notificationTimeLabel.font = Themes.fontRegularMakeAppInfo
    notificationTimeLabel.textColor = Themes.colorGrayScale
    notificationTimeBackgroundView.backgroundColor = Themes.colorCharcoal
    indicatorView.backgroundColor = Themes.colorGrayScale
    expandMoreImage.tintColor = Themes.colorSolidWhite
  }
}
