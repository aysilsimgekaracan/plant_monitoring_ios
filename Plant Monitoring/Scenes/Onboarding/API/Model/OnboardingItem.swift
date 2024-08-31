//
//  OnboardingItem.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 22.08.2024.
//

import Foundation

public struct OnboardingItems: Codable {
  let data: [OnboardingItem]
}

public struct OnboardingItem: Codable {
  let title: String
  let subtitle: String
  let imageName: String
}
