//
//  View.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 4.09.2024.
//

import UIKit

public class View: UIView {
  @IBInspectable var borderColor: UIColor? {
    get {
      guard let cgColor = layer.borderColor else {
        return nil
      }
      return UIColor(cgColor: cgColor)
    }
    set { layer.borderColor = newValue?.cgColor }
    }

  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
}
