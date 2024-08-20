//
//  UIImageView+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 20.08.2024.
//

import UIKit

extension UIImageView {
  func setImage(with url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
