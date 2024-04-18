//
//  PlantDetailViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.04.2024.
//

import UIKit

public final class PlantDetailViewModel {
  var coordinator: PlantDetailCoordinator!
  var plant: PlantItem

  init(coordinator: PlantDetailCoordinator, plant: PlantItem) {
    self.coordinator = coordinator
    self.plant = plant
  }

  // MARK: - Navigation

  public func navigateBack() {
    coordinator.navigateBack()
  }

}
