//
//  OnboardingViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 22.08.2024.
//

import Foundation
import PromiseKit

public final class OnboardingViewModel {
  var coordinator: OnboardingCoordinator!

  init(coordinator: OnboardingCoordinator!) {
    self.coordinator = coordinator
  }

  public func start() -> Promise<OnboardingDisplay> {
    return Promise { seal in
      loadJson(filename: "GetOnboardingItems").done { onboardingItems in
        seal.fulfill(OnboardingDisplay(onboardings: onboardingItems.data))
      }.catch { err in
        print(err.localizedDescription)
        seal.reject(err)
      }
    }
  }

  func loadJson(filename fileName: String) -> Promise<OnboardingItems> {
    return Promise { seal in
      if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
          do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(OnboardingItems.self, from: data)
            seal.fulfill(jsonData)
          } catch {
            seal.reject(error)
        }
      }
    }
  }
}
