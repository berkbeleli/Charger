//
//  NotifivationTimeTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class NotificationTimeTableViewCell: UITableViewCell {
  @IBOutlet private weak var notififcationTimeBackgroundView: UIView!
  @IBOutlet private(set) weak var notificationTimeLabel: UILabel!
  @IBOutlet private weak var expandMoreImage: UIImageView!
  @IBOutlet private weak var indicatorView: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

  // setup view
  func setupUI() {
    notificationTimeLabel.font = Themes.fontRegularSubtitle
    notificationTimeLabel.textColor = Themes.colorGrayScale
    notififcationTimeBackgroundView.backgroundColor = Themes.colorCharcoal
    indicatorView.backgroundColor = Themes.colorGrayScale
    expandMoreImage.tintColor = Themes.colorGrayScale
  }
    
}
