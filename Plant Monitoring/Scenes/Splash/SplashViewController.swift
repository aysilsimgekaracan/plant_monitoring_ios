//
//  SplashViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import UIKit

class SplashViewController: UIViewController {
    // MARK: - Variables
  var viewModel: SplashViewModel!
  
  init(viewModel: SplashViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    viewModel.proceed()
  }
}
