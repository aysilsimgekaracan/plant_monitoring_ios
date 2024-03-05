//
//  SplashViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import Foundation
import PromiseKit

class SplashViewModel {
  var coordinator: SplashCoordinator!

  init(coordinator: SplashCoordinator!) {
    self.coordinator = coordinator
  }

  func start() -> Promise<SplashDisplay> {
    return Promise { seal in
      TokenService.shared.start().done { _ in
        seal.fulfill(SplashDisplay(isAuthSuccess: true))
      }.catch { _ in
        seal.fulfill(SplashDisplay(isAuthSuccess: false))
      }
    }
  }

  // MARK: - Navigation

  func proceed() {
    coordinator.startTabBar()
  }
}
