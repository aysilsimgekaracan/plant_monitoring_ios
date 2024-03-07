//
//  PlantsCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.03.2024.
//

import UIKit

public final class PlantsCoordinator: Coordinator {
  var navigationController: UINavigationController = UINavigationController()
  let image = UIImage(systemName: "leaf.fill")

  func start() {
    let storyboard = UIStoryboard(name: "Plants", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "Plants")
            as? PlantsViewController else {
      fatalError()
    }

    let viewModel = PlantsViewModel(coordinator: self)
    viewController.viewModel = viewModel

    let tabBarTitle = "tab.plants".localized()
    navigationController.tabBarItem = UITabBarItem(title: tabBarTitle, image: image, tag: 1)
    navigationController.isNavigationBarHidden = true
    navigationController.viewControllers = [viewController]
  }

}
