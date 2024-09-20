//
//  UIImage+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 20.09.2024.
//

import UIKit

extension UIImage {
  /// Resizes the image to the specified size.
  ///
  /// - Parameter size: The target size to resize the image to.
  /// - Returns: A new image resized to the specified size, or `nil` if the operation fails.
  func resizedImage(to size: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
