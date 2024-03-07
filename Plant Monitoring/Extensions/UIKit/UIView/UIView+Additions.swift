//
//  UIView+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 6.03.2024.
//

import UIKit

extension UIView {

  // MARK: - Tap Animation

  func animateTappedEffect() {
    let view = self

    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
      view.alpha = 0.4
    }, completion: { _ in
      view.alpha = 1
    })
  }
}
