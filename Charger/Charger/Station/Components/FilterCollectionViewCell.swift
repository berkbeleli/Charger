//
//  FilterCollectionViewCell.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
  var deleteFilter: ((String) -> ())?
  @IBOutlet private weak var bgFilterView: UIView!
  @IBOutlet private(set) weak var filterLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  /// setup the ui
  func setupUI() {
    bgFilterView.layer.cornerRadius = ObjectConstants.stationfilterbuttonBorderRadius
    bgFilterView.layer.borderWidth = 2
    bgFilterView.backgroundColor = Themes.colorDark
    bgFilterView.layer.borderColor = Themes.colorSelectedGreen.cgColor
    filterLabel.font = Themes.fontRegular
    filterLabel.textColor = Themes.colorSolidWhite
  }
  /// handle deletion of a filter item
  @IBAction func deleteFilterButton(_ sender: UIButton) {
    deleteFilter?("DeletedFilter")
  }
  
}
