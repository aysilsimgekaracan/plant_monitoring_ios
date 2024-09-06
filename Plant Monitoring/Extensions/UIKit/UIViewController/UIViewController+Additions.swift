//
//  UIViewController+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.08.2024.
//

import UIKit
import Lottie

extension UIViewController {
  // MARK: Loading Indicator

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

  // MARK: Keyboard Observer

  func addKeyboardObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotifications(notification:)),
                                             name: UIResponder.keyboardWillChangeFrameNotification,
                                             object: nil)
  }

  func removeKeyboardObserver() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }

  // This method will notify when keyboard appears/ dissapears
  @objc func keyboardNotifications(notification: NSNotification) {
    var txtFieldY: CGFloat = 0.0  // Using this we will calculate the selected textFields Y Position
    let spaceBetweenTxtFieldAndKeyboard: CGFloat = 5.0 // Specify the space between textfield and keyboard

    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
      // Here we will get accurate frame of textField which is selected if there are multiple textfields
      frame = self.view.convert(activeTextField.frame, from: activeTextField.superview)
      txtFieldY = frame.origin.y + frame.size.height
    }

    if let userInfo = notification.userInfo {
      // here we will get frame of keyBoard (i.e. x, y, width, height)
      let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let keyBoardFrameY = keyBoardFrame!.origin.y
      let keyBoardFrameHeight = keyBoardFrame!.size.height

      var viewOriginY: CGFloat = 0.0
      // Check keyboards Y position and according to that move view up and down
      if keyBoardFrameY >= UIScreen.main.bounds.size.height {
          viewOriginY = 0.0
      } else {
        // If textfields y is greater than keyboards y then only move View to up
        if txtFieldY >= keyBoardFrameY {

          viewOriginY = (txtFieldY - keyBoardFrameY) + spaceBetweenTxtFieldAndKeyboard

          // This condition is just to check viewOriginY should not be greator than keyboard height
          // if its more than keyboard height then there will be black space on the top of keyboard.
          if viewOriginY > keyBoardFrameHeight { viewOriginY = keyBoardFrameHeight }
        }
      }

      // Set the Y position of view
      self.view.frame.origin.y = -viewOriginY
    }
  }

  // Keyboard Dismiss
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

   @objc func dismissKeyboard() {
     view.endEditing(true)
   }
}
