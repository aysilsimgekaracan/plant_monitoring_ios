//
//  CreatePlantItem.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 17.09.2024.
//

import Foundation

public struct CreatePlantItem: Codable, Identifiable {
  public let id: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
  }
}
