//
//  SplashViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import UIKit

public final class SplashViewController: UIViewController {
 
  // MARK: - IBOutlets

  @IBOutlet weak var animationView: UIView!

  // MARK: - Properties

  var viewModel: SplashViewModel!
  let animationDuration = 1.0

  // MARK: - View Lifecylce

  init(viewModel: SplashViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  public override func viewDidLoad() {
    animateBackgroundAndProceed()
  }
  
  // MARK: - Private Helpers
  
  private func animateBackgroundAndProceed() {
    UIView.animate(withDuration: animationDuration) {
      self.animationView.layer.cornerRadius = 120
      self.animationView.backgroundColor = .green
      self.animationView.layer.opacity = 0.4
      self.animationView.layer.masksToBounds = true

      self.animationView.layoutIfNeeded()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      self.viewModel.proceed()
    }
  }
  
  
}
