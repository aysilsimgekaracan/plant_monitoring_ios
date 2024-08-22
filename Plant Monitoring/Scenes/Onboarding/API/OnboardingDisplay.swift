//
//  OnboardingDisplay.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 22.08.2024.
//

import Foundation

public struct OnboardingDisplay {
  let onboardings: [OnboardingItem]
  
  static let empty: OnboardingDisplay = OnboardingDisplay(onboardings: [])
}
