//
//  OnboardingCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 22.08.2024.
//

import UIKit

public final class OnboardingCoordinator: Coordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(
      withIdentifier: "Onboarding") as? OnboardingViewController else {
      fatalError()
    }

    let viewModel = OnboardingViewModel(coordinator: self)
    viewController.viewModel = viewModel
    viewController.hidesBottomBarWhenPushed = true

    navigationController.isNavigationBarHidden = true
    navigationController.pushViewController(viewController, animated: true)
  }

  func navigateBack() {
    navigationController.popViewController(animated: true)
  }
}
