//
//  LoginViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation

class LoginViewModel {
  var onLoginRequested: ((String) -> ())?
  
  // With this function we can request api to login with given email
  func loginRequest(email: String?) {
    
    let parameters: [String: String] = ["email": email ?? "", "deviceUDID": AppConstants.deviceUDID]
    
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
