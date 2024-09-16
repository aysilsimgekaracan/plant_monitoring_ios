//
//  GetDevicesTask.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.09.2024.
//

import Foundation

public struct GetDevicesTask: HTTPTask {
  var endpoint: String = "/GetDevices"

  var method: HTTPMethod = .get

  var parameters: [String: Any]?

  var additionalHeaders: [String: Any]?

  typealias ResponseType = [DeviceItem]
}
