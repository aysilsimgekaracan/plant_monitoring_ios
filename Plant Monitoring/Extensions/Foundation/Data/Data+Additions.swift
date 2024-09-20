//
//  Data+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 20.09.2024.
//

import Foundation

extension Data {
  /// Appends a string to the data using UTF-8 encoding.
  ///
  /// - Parameter string: The string to append.
  mutating func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      append(data)
    }
  }
}
