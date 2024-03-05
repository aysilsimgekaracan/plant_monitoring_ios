//
//  HomeCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import Foundation
import UIKit

public final class HomeCoordinator: Coordinator {
  var navigationController: UINavigationController! = UINavigationController()
  let homeStoryboard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "Home")
  let image = UIImage(systemName: "house.fill")

  func start() {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: "Home")
            as? HomeViewController else {
      fatalError()
    }
    let viewModel = HomeViewModel(coordinator: self)
    viewController.viewModel = viewModel

    let tabBarTitle = "tab.home".localized()
    navigationController.tabBarItem = UITabBarItem(title: tabBarTitle, image: image, tag: 0)
    navigationController.isNavigationBarHidden = true
    navigationController.viewControllers = [viewController]
  }
}
