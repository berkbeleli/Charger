//
//  UserToken.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation
import Alamofire

struct UserToken {
  static var token: HTTPHeaders = ["token" : "\(User.user?.token ?? "invalid token")"]
}
