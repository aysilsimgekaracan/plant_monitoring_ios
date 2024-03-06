//
//  Label.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.03.2024.
//

import UIKit

public class Label: UILabel {
  @IBInspectable var localizedText: String? {
    get { text }
    set { text = newValue?.localized() }
  }

}
