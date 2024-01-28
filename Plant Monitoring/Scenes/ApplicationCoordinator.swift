//
//  ApplicationCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import UIKit

class ApplicationCoordinator: Coordinator {
  public static var shared = ApplicationCoordinator()
  
  var window: UIWindow!
  var tabBarCoordinator: TabBarCoordinator?
  var splashCoordinator: SplashCoordinator?
  
  init(window: UIWindow = UIWindow()) {
    self.window = window
  }
  
  func start() {
    splashCoordinator = SplashCoordinator()
    splashCoordinator?.start()
    
    window.rootViewController = splashCoordinator?.navigationController
    window.makeKeyAndVisible()
  }
  
  func showTabBar() {
    tabBarCoordinator = TabBarCoordinator()
    tabBarCoordinator?.start()
    
    window.rootViewController = tabBarCoordinator?.tabBarController
  }
}
