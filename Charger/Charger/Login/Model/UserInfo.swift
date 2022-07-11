//
//  UserInfo.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation

struct User {
  static var user: UserInfo?
}

struct UserInfo: Codable {
  var userId: Int?
  var token: String?
  var email: String?
  
  enum CodingKeys: String, CodingKey {
      case userId = "userID"
      case token
      case email
  }
  
}
