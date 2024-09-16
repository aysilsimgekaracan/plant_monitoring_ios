//
//  AvailableDevicesItem.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.09.2024.
//

import Foundation

public struct AvailableDevicesItem: Codable {
  let devices: [AvailableDeviceItem]
}

public struct AvailableDeviceItem: Codable, Identifiable {
  public let id: String
  let plantId: String?
  let deviceName: String
  let serialNumber: String?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case plantId = "plant_id"
    case deviceName = "device_name"
    case serialNumber = "serial_number"
  }
}
