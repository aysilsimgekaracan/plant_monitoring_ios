//
//  AddPlantCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 2.09.2024.
//

import Foundation
import UIKit

public final class AddPlantCoordinator: Coordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let storyboard = UIStoryboard(name: "AddPlant", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "AddPlant")
            as? AddPlantViewController else {
      fatalError()
    }

    let viewModel = AddPlantViewModel(coordinator: self)
    viewController.viewModel = viewModel
    viewController.hidesBottomBarWhenPushed = true

    navigationController.isNavigationBarHidden = true
    navigationController.pushViewController(viewController, animated: true)
  }

  func showImagePickerSheet(delegate: ImagePickerSheetDelegate) {
    let coordinator = ImagePickerSheetCoordinator(navigationController: navigationController, delegate: delegate)
    coordinator.start()
  }
  
  func showAddDevice() {
    let coordinator = AddDeviceCoordinator(navigationController: navigationController)
    coordinator.start()
  }

  func navigateBack() {
    navigationController.popViewController(animated: true)
  }
}
