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
  private var display: SplashDisplay! {
    didSet {
      proceed()
    }
  }

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
    getDisplay()
  }

  // MARK: - Private Helpers

  private func getDisplay() {
    viewModel.start().done { display in
      self.display = display
    }.cauterize()
  }

  private func animateBackgroundAndProceed() {
    UIView.animate(withDuration: animationDuration) {
      self.animationView.layer.cornerRadius = 120
      self.animationView.backgroundColor = .green
      self.animationView.layer.opacity = 0.4
      self.animationView.layer.masksToBounds = true

      self.animationView.layoutIfNeeded()
    }
  }

  private func proceed() {
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      if self.display.isAuthSuccess {
        self.viewModel.proceed()
      } else {
        // Give alert to user if request is not successfull, and try requesting again

        NotificationService.shared.showNotification(layout: .centered,
                                                    theme: .errorb,
                                                    title: "notification.service.error.title".localized(),
                                                    body: "notification.service.http.request.error.body".localized(),
                                                    buttonTitle: "notification.service.button.title".localized(),
                                                    completion: { self.getDisplay() })
      }
    }
  }

}
