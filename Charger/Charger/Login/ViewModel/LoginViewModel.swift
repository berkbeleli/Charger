//
//  LoginViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation

class LoginViewModel {
  var onLoginRequested: ((String) -> ())?
  
  ///With this function you can ask user for location Info
  func requestLocation() {
    LocationManager.shared.checkLocationService()
  }
  // request Notification permission
  func requestNotificationPermission() {
    NotificationManager.shared.requestPermission()
  }
  
  /// With this function we can request api to login with given email
  func loginRequest(email: String?) {
    if !(email!.isValidEmail()) { // firstly check if the email is valid
      onLoginRequested?("EMAIL_NOT_IN_CORRECT_FORM")
    } else {
      
      let parameters: [String: String] = ["email": email ?? "", "deviceUDID": AppConstants.deviceUDID] // creae parameters with received datas
      
      WebServiceHelper.instance.getServiceData(url: WebsiteUrl.loginUrl, method: .post, parameters: parameters) { [weak self] (returnedResponse: UserInfo!, errorString: String?) in
        if errorString == nil {
          User.user = returnedResponse

          self?.onLoginRequested?("SUCCESS")
        }else {
          // SHOW ERROR PAGE HERE!!!!
          print(errorString ?? "UNKNOWN ERROR")
          self?.onLoginRequested?(errorString ?? "UNKNOWN ERROR")
        }
      }
      
    }
    
  }
}
