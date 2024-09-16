//
//  GetAvailableDevicesTask.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.09.2024.
//

import Foundation

public struct GetAvailableDevicesTask: HTTPTask {
  var endpoint: String = "/GetAvailableDevices"

  var parameters: [String: Any]?

  var additionalHeaders: [String: Any]?

  typealias ResponseType = [AvailableDeviceItem]

  var method: HTTPMethod = .get
}
