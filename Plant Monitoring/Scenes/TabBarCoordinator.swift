//
//  TabBarCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import UIKit

class TabBarCoordinator: Coordinator {
  let tabBarController: UITabBarController = UITabBarController()

  func start() {
    let homeCoordinator = HomeCoordinator()
    homeCoordinator.start()

    let plantsCoordinator = PlantsCoordinator()
    plantsCoordinator.start()

    tabBarController.tabBar.isTranslucent = false
    tabBarController.tabBar.barTintColor = .white
    tabBarController.tabBar.tintColor = Colors.plantMiddleGreen
    tabBarController.tabBar.unselectedItemTintColor = .lightGray
    tabBarController.tabBar.standardAppearance.configureWithOpaqueBackground()

    if #available(iOS 15, *) {
      let appearance = UITabBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .white
      tabBarController.tabBar.standardAppearance = appearance
      tabBarController.tabBar.scrollEdgeAppearance = appearance
    }

    tabBarController.viewControllers = [homeCoordinator.navigationController, plantsCoordinator.navigationController]
  }
}
