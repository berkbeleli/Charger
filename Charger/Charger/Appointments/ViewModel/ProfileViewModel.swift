//
//  ProfileViewModel.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation

class ProfileViewModel {
  var onLogoutRequested: ((String) -> ())? // with this closure we will let the result of the logout request to our vc
  
  /// With this func we can request for logout from api
  func logOutRequest() {
    
    let logOutUrl = WebsiteUrl.logOutUrl + "\(User.user?.userId ?? -1)"
    
    WebServiceHelper.instance.getServiceData(url: logOutUrl, method: .post, header: UserToken.token ,logout: true) { [weak self] (returnedResponse: String!, errorString: String?) in
      if errorString == nil {
        self?.onLogoutRequested?("SUCCESS")
      }else {
        // SHOW ERROR PAGE HERE!!!!
        print(errorString ?? "UNKNOWN ERROR")
        self?.onLogoutRequested?(errorString ?? "UNKNOWN ERROR")
      }
    }
  }
}
