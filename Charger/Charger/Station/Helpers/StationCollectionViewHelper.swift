//
//  StationCollectionViewHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-14.
//

import UIKit

class StationCollectionViewHelper: NSObject {
  private var allFilters: [String] = []
  weak var vm: StationViewModel?
  weak var collectionView: UICollectionView?
  
  init(with tableView: UICollectionView, vm: StationViewModel){
    super.init()
    self.collectionView = tableView
    self.vm = vm
    self.collectionView?.delegate = self // get tableview's delegations
    self.collectionView?.dataSource = self
    registerCell()
  }
  /// Register custom cell to our tableView
  func registerCell(){
    collectionView?.register(.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
  }
  /// This function set the table view items and reload the table view
  func setItems(_ items: [String]) {
    self.allFilters = items
    collectionView?.reloadData()
  }
}
//MARK: - UICollectionViewDataSource
extension StationCollectionViewHelper: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell

    cell.filterLabel.text = allFilters[indexPath.row].localizeString()
    cell.deleteFilter = {[weak self] _ in
      self?.vm!.removeFilter(filterName: (self?.allFilters[indexPath.row])!)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    allFilters.count
  }
  
  
}

extension StationCollectionViewHelper: UICollectionViewDelegate {
  
}

extension StationCollectionViewHelper: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    .init(top: 0, left: 8, bottom: 0, right: 8) // give padding 8 pixed left and right of the collection view
  }
}
