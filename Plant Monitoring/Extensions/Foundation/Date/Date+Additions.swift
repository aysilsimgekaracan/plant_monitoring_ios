//
//  Date+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 30.04.2024.
//

import Foundation

enum CustomDateFormats: String {
  /// yyyy-mm-dd like 2024-01-30
  case yearMonthDay = "yyyy-mm-dd"
}

extension Date {
  func toString(format: String = "yyyy-MM-dd") -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .short
          formatter.dateFormat = format
          return formatter.string(from: self)
      }
}
