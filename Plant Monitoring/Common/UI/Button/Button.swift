//
//  Button.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 22.08.2024.
//

import UIKit

public class Button: UIButton {
  @IBInspectable var localizedText: String? {
    get { titleLabel?.text }
    set { setTitle(newValue?.localized(), for: .normal) }
  }
}
