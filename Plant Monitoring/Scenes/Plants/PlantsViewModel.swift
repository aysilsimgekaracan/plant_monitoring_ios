//
//  PlantsViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.03.2024.
//

import PromiseKit

public final class PlantsViewModel {
  var coordinator: PlantsCoordinator

  init(coordinator: PlantsCoordinator) {
    self.coordinator = coordinator
  }

  public func getPlants() -> Promise<[PlantItem]> {
    return Promise { seal in
      APIService.shared.performRequest(task: GetPlantsTask()).done { plants in
        seal.fulfill(plants)
      }.catch { err in
        print(err.localizedDescription)
        seal.reject(err)
      }
    }
  }
  
  public func showPlantDetail(for plant: PlantItem) {
    coordinator.showPlantDetail(with: plant)
  }

}
