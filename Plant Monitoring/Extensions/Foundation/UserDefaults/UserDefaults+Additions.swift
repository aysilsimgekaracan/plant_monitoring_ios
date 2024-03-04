//
//  UserDefaults+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 1.03.2024.
//

import Foundation

extension UserDefaults {
  // Set value for a given key
  func set<T>(value: T, for key: UserDefaultsKeys) {
      set(value, forKey: key.rawValue)
  }
  
  // Get value for a given key, with a generic return type
  func value<T>(for key: UserDefaultsKeys) -> T? {
      return value(forKey: key.rawValue) as? T
  }
  
  // You can add more specific methods for convenience, for example:
  func string(for key: UserDefaultsKeys) -> String? {
      return string(forKey: key.rawValue)
  }
  
  func integer(for key: UserDefaultsKeys) -> Int {
      return integer(forKey: key.rawValue)
  }
  
  func bool(for key: UserDefaultsKeys) -> Bool {
      return bool(forKey: key.rawValue)
  }
}
