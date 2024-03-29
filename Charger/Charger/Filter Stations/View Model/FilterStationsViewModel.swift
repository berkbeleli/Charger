//
//  FilterStationsViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-13.
//

import Foundation

class FilterStationsViewModel {
  var onFiltersChanged: ((String) -> ())?
  var onFiltersRequested: ((FilterModel) -> ())?

  var filterValues: FilterModel?
  // checks for previous filter
  func updateFilters() {
    onFiltersChanged?("Update") // call closure check if the previous filter exist
  }
  // clear filters
  func clearFilters() {
    filterValues = .init(deviceTypes: [], socketTypes: [], distance: nil, services: [])
    onFiltersChanged?("Update") // call closure check if the previous filter exist
  }
  
  /// Adds or remove the given device type filter
  func addDeviceFilter(filter: DeviceType) {
    if filterValues?.deviceTypes?.contains(filter) ?? false{
      filterValues?.deviceTypes?.removeAll { $0.rawValue == filter.rawValue }
    }else {
      filterValues?.deviceTypes?.append(filter)
    }
    onFiltersChanged?("Update") // call closure as an item added or removed
  }
  /// Checks if exist  the given device type filter
  func checkContainsDeviceValue(filter: DeviceType) -> Bool {
    filterValues?.deviceTypes?.contains(filter) ?? false
  }
  /// Adds or remove the given socket type filter
  func addSocketFilter(filter: SocketType) {
    if filterValues?.socketTypes?.contains(filter) ?? false{
      filterValues?.socketTypes?.removeAll { $0.rawValue == filter.rawValue }
    }else {
      filterValues?.socketTypes?.append(filter)
    }
    onFiltersChanged?("Update") // call closure as an item added or removed
  }
  /// Checks if exist  the given socket type filter
  func checkContainsSocketValue(filter: SocketType) -> Bool {
    filterValues?.socketTypes?.contains(filter) ?? false
  }
  /// Adds the given distance filter
  func addDistanceFilter(filter: Double) {
      filterValues?.distance = filter
  }
  
  func getDistanceValue() -> Float {
    Float(filterValues?.distance ?? 0)
  }
  
  func checkDistanceExist() -> Bool {
    filterValues?.distance != nil
  }
  /// Adds or remove the given service type filter
  func addServiceFilter(filter: Services) {
    if filterValues?.services?.contains(filter) ?? false{
      filterValues?.services?.removeAll { $0.rawValue == filter.rawValue }
    }else {
      filterValues?.services?.append(filter)
    }
    onFiltersChanged?("Update") // call closure as an item added or removed
  }
  /// Checks if exist  the given service type filter
  func checkContainsServiceValue(filter: Services) -> Bool {
    filterValues?.services?.contains(filter) ?? false
  }
  /// Request All Of the Filters
  func requestAllFilters() -> FilterModel {
    return filterValues ?? FilterModel(deviceTypes: [], socketTypes: [], services: [])
  }
}
