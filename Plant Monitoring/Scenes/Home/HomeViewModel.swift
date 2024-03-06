//
//  HomeViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import Foundation

public final class HomeViewModel {
  var coordinator: HomeCoordinator!

  init(coordinator: HomeCoordinator) {
    self.coordinator = coordinator
  }
  
  func showPlants() {
    coordinator.showPlants()
  }

}
