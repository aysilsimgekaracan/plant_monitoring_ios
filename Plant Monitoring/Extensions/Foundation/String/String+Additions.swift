//
//  String+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import Foundation

public extension String {
  static let empty = ""

  func localized(comment: String = .empty) -> String {
    return NSLocalizedString(self, comment: comment)
  }
}
