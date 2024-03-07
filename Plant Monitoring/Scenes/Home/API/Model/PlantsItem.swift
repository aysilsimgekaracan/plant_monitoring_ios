//
//  PlantsItem.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.03.2024.
//

import Foundation

public struct PlantsItem: Codable {
  let plants: [PlantItem]
}

public struct PlantItem: Codable, Identifiable {
  public let id: String
  let name: String
  let type: String
  let location: String
  let description: String
}
