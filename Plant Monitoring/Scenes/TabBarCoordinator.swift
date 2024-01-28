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
    
    tabBarController.viewControllers = [homeCoordinator.navigationController]
  }
}
