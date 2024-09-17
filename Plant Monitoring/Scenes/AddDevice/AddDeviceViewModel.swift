//
//  AddDeviceViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 17.09.2024.
//

import Foundation

public final class AddDeviceViewModel {
  var coordinator: AddDeviceCoordinator
  
  init(coordinator: AddDeviceCoordinator) {
    self.coordinator = coordinator
  }
  
  // MARK: Navigation
  
  func showBack() {
    coordinator.navigateBack()
  }
}
