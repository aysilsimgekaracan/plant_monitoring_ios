//
//  NSData+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 18.09.2024.
//

import Foundation

extension NSMutableData {
  /**
     Appends a string to `NSMutableData` by converting it to `Data`.

     - Parameter string: The string to append.
   */
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      append(data)
    }
  }
}
