//
//  TimeSelectionTableViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-15.
//

import UIKit

class TimeSelectionTableViewCell: UITableViewCell {
  @IBOutlet private weak var timeBackgroundView: UIView!
  @IBOutlet private(set) weak var timeLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
  
  func setupUI() {
    timeBackgroundView.backgroundColor = Themes.colorCharcoal
    timeBackgroundView.layer.cornerRadius = ObjectConstants.timeSelectionBorderRadius
    timeLabel.font = Themes.fontRegularSubtitle
    timeLabel.textColor = Themes.colorSolidWhite
  }
  /// disable cell
  func disableCell(){
    timeLabel.alpha = 0.2
  }
  
  func normalCell(){
    timeLabel.alpha = 1
  }

  /// when user select the cell
  func selectCell() {
    timeBackgroundView.layer.borderWidth = 3
    timeBackgroundView.layer.borderColor = Themes.colorSelectedGreen.cgColor
    timeBackgroundView.backgroundColor = Themes.colorDark
  }
  /// When user deselect Cell
  func deSelectCell() {
    timeBackgroundView.layer.borderWidth = 0
    timeBackgroundView.layer.borderColor = UIColor.clear.cgColor
    timeBackgroundView.backgroundColor = Themes.colorCharcoal
  }
}
