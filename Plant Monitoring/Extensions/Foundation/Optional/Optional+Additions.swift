//
//  Optional+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 7.09.2024.
//

import Foundation

extension Optional where Wrapped == String {
  var emptyIfNil: String {
    return self ?? .empty
  }
}
