//
//  SplashCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import UIKit

public final class SplashCoordinator: Coordinator {
  var navigationController: UINavigationController! = UINavigationController()

  func start() {
    let storyboard = UIStoryboard(name: "Splash", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "Splash")
            as? SplashViewController else {
      fatalError()
    }
    let viewModel = SplashViewModel(coordinator: self)
    viewController.viewModel = viewModel

    navigationController.viewControllers = [viewController]
  }

  func startTabBar() {
    ApplicationCoordinator.shared.showTabBar()
  }
}
