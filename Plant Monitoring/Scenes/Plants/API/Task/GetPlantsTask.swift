//
//  GetPlantsTask.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 12.03.2024.
//

import Foundation

public struct GetPlantsTask: HTTPTask {

  typealias ResponseType = [PlantItem]

  var endpoint: String = "/GetPlants"

  var method: HTTPMethod = .get

  var parameters: [String: Any]?

  var additionalHeaders: [String: Any]?

}
