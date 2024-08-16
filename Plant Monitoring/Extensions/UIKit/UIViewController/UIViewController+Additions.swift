//
//  UIViewController+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.08.2024.
//

import UIKit
import Lottie

extension UIViewController {
  private struct LoadingViewConstants {
    static var loadingViewKey: UInt8 = 0
  }

  func showLoadingIndicator() {
    guard objc_getAssociatedObject(self, &LoadingViewConstants.loadingViewKey) == nil else {
      // If loading view is already present, return
      return
    }

    // Create a very subtle blur effect
    let blurEffect = UIBlurEffect(style: .extraLight) // Use extra light for minimal blur
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.alpha = 0.2 // Adjust the alpha to control the intensity of the blur
    blurEffectView.frame = self.view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    // Create lottie loading indicator
    let lottieLoadingAnimation = LottieAnimationView(name: "loading-animation")
    lottieLoadingAnimation.translatesAutoresizingMaskIntoConstraints = false
    lottieLoadingAnimation.contentMode = .scaleAspectFit
    lottieLoadingAnimation.loopMode = .loop
    lottieLoadingAnimation.animationSpeed = 2
    lottieLoadingAnimation.play()

    // Create a container view for the blur effect and activity indicator
    let loadingContainer = UIView(frame: self.view.bounds)
    loadingContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    loadingContainer.isUserInteractionEnabled = true // Capture all touches to block interaction

    // Add blur and lottie animation to the container
    loadingContainer.addSubview(blurEffectView)
    loadingContainer.addSubview(lottieLoadingAnimation)

    // Center and resize the lottie animation
    NSLayoutConstraint.activate([
      lottieLoadingAnimation.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor),
      lottieLoadingAnimation.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor),
      lottieLoadingAnimation.widthAnchor.constraint(equalToConstant: 100),
      lottieLoadingAnimation.heightAnchor.constraint(equalToConstant: 100)
    ])

    // Store the loading container view using associated objects
    objc_setAssociatedObject(self,
                             &LoadingViewConstants.loadingViewKey,
                             loadingContainer,
                             .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    // Add the loading view to the current view controller's view
    self.view.addSubview(loadingContainer)
  }

  func hideLoadingIndicator() {
    if let loadingView = objc_getAssociatedObject(self, &LoadingViewConstants.loadingViewKey) as? UIView {
      loadingView.removeFromSuperview()
      objc_setAssociatedObject(self, &LoadingViewConstants.loadingViewKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
