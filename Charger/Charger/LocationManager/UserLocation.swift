//
//  UserLocation.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager() // singleton to reach and request user location
    let manager = CLLocationManager()
    private override init() { }
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() { // checks if the location service is enabled
            setupLocationManager()
            checkLocationManagerAuthorization()
        }
    }
    
    func setupLocationManager() {
        manager.delegate = self // get location delegate to current class
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationManagerAuthorization() {
        switch authorizationStatus() { // control authorization status
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            break
        default:
            break
        }
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = CLLocationManager().authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        return status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let object: [String: Any] = [
                "error": false,
                "location": location
            ]
            DispatchQueue.main.async { // after receiving the user location set the UserLocation Datas
              
              guard let location = object["location"] as? CLLocation else { return } // control location data
              LocationDatas.shared.locationlatitude = location.coordinate.latitude
              LocationDatas.shared.locationlongitude = location.coordinate.longitude
            }
            
            manager.stopUpdatingLocation() // stop receiving location
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationService() // check after the user change authoriation of the app
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation() // if there was error when trying to receive user location stopUpdating the locationData
    }
}
