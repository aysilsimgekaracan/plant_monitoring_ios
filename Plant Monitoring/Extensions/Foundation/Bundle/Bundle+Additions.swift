//
//  Bundle+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 20.02.2024.
//

import Foundation

public extension Bundle {
  func infoDictionaryValue<V>(forKey key: String) -> V {
    return object(forInfoDictionaryKey: key) as! V
  }
}
