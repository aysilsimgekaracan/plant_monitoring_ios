//
//  AddPlantDisplay.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.09.2024.
//

import Foundation

public struct AddPlantDisplay {
  let cameraDeniedTitle = "add.plant.camera.access.denied.title".localized()
  let cameraDeniedDescription = "add.plant.library.access.denied.description".localized()
  let libraryDeniedTitle = "add.plant.library.access.denied.title".localized()

  public let availableDevices: [AvailableDeviceItem]

  static let empty: AddPlantDisplay = AddPlantDisplay(availableDevices: [])

  public init(availableDevices: [AvailableDeviceItem]) {
    self.availableDevices = availableDevices
  }
}
