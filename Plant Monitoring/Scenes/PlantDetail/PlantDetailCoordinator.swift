//
//  PlantDetailCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.04.2024.
//

import UIKit

public final class PlantDetailCoordinator: Coordinator {
  var navigationController: UINavigationController
  var plant: PlantItem

  init(navigationController: UINavigationController, plant: PlantItem) {
    self.navigationController = navigationController
    self.plant = plant
  }

  func start() {
    let storyboard = UIStoryboard(name: "PlantDetail", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "PlantDetail")
            as? PlantDetailViewController else {
      fatalError()
    }

    let viewModel = PlantDetailViewModel(coordinator: self, plant: plant)
    viewController.viewModel = viewModel
    viewController.hidesBottomBarWhenPushed = true

    navigationController.isNavigationBarHidden = true
    navigationController.pushViewController(viewController, animated: true)

  }

  func navigateBack() {
    navigationController.popViewController(animated: true)
  }
}
