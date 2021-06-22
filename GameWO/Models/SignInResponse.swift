//
//  SignInResponse.swift
//  GameWO
//
//  Created by Belal medhat on 6/20/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation
struct SignInResponse:Codable {
    
   enum CodingKeys: String, CodingKey {
        case objectId
        case updatedAt
        case phone = "Phone"
        case emailVerified
        case email
        case username
        case sessionToken
        case createdAt
      }

      var objectId: String?
      
      var updatedAt: String?
      var phone: String?
      var emailVerified: Bool?
      var email: String?
      var username: String?
      var sessionToken: String?
      var createdAt: String?



      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        objectId = try container.decodeIfPresent(String.self, forKey: .objectId)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        emailVerified = try container.decodeIfPresent(Bool.self, forKey: .emailVerified)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        sessionToken = try container.decodeIfPresent(String.self, forKey: .sessionToken)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
      }

    

}
