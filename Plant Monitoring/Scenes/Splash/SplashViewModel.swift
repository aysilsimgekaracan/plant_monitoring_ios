//
//  SplashViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import Foundation

class SplashViewModel {
  var coordinator: SplashCoordinator!
  
  init(coordinator: SplashCoordinator!) {
    self.coordinator = coordinator
  }
  
  func proceed() {
    coordinator.startTabBar()
  }
}
