//
//  AddPlantDisplay.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.09.2024.
//

import Foundation
import UIKit

public struct PlantDetails {
  var name: String
  var type: String
  var location: String
  var description: String
  var isValid: Bool

  static let empty: PlantDetails = PlantDetails(name: "", type: "", location: "", description: "", isValid: false)
}

public struct AddPlantDisplay {
  let cameraDeniedTitle = "add.plant.camera.access.denied.title".localized()
  let cameraDeniedDescription = "add.plant.library.access.denied.description".localized()
  let libraryDeniedTitle = "add.plant.library.access.denied.title".localized()

  public let availableDevices: [AvailableDeviceItem]
  public var plantDetails: PlantDetails
  public var plantImage: UIImage?

  static let empty: AddPlantDisplay = AddPlantDisplay(availableDevices: [], plantDetails: PlantDetails.empty)

  public init(availableDevices: [AvailableDeviceItem], plantDetails: PlantDetails, image: UIImage? = nil) {
    self.availableDevices = availableDevices
    self.plantDetails = plantDetails
  }
}
