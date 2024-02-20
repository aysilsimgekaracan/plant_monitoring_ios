//
//  ConfigLoader.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 20.02.2024.
//

import Foundation

public final class ConfigLoader {
  private typealias ConfigType = [String: Any]

  public static let shared = ConfigLoader()

  private lazy var config: ConfigType = readConfig()

  private func readConfig() -> ConfigType {
    Bundle.main.infoDictionaryValue(forKey: "Config")
  }

  public subscript<E>(key: String) -> E {
    guard let value = config[key] as? E else {
      fatalError()
    }
    return value
  }

}
