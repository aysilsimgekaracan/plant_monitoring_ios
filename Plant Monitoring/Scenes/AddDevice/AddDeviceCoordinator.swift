//
//  AddDeviceCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 17.09.2024.
//

import Foundation
import UIKit

public final class AddDeviceCoordinator: Coordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let storyboard = UIStoryboard(name: "AddDevice", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(
      withIdentifier: "AddDevice") as? AddDeviceViewController else {
      fatalError()
    }
    let viewModel = AddDeviceViewModel(coordinator: self)
    viewController.viewModel = viewModel
    viewController.hidesBottomBarWhenPushed = true

    navigationController.isNavigationBarHidden = true
    navigationController.pushViewController(viewController, animated: true)
  }

  func navigateBack() {
    navigationController.popViewController(animated: true)
  }
}
