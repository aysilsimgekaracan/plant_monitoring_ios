//
//  TokenItem.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 29.02.2024.
//

import Foundation

public struct TokenItem: Codable {
  let accessToken: String
  let tokenType: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
  }
}
