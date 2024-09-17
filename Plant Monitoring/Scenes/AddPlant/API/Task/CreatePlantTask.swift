//
//  CreatePlantTask.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 17.09.2024.
//

import Foundation

public struct CreatePlantTask: HTTPTask {
  var endpoint: String = "/CreatePlant"

  var method: HTTPMethod = .post

  var parameters: [String: Any]?

  var additionalHeaders: [String: Any]?

  typealias ResponseType = CreatePlantItem

  public init(name: String, type: String, location: String, description: String) {
    self.parameters = ["name": name, "type": type, "location": location, "description": description]
  }
}
