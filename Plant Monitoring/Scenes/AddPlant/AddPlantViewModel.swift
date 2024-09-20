//
//  AddPlantViewModel.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 2.09.2024.
//

import Foundation
import AVFoundation
import PhotosUI
import PromiseKit

public final class AddPlantViewModel {
  var coordinator: AddPlantCoordinator

  init(coordinator: AddPlantCoordinator) {
    self.coordinator = coordinator
  }

  public func start() -> Promise<AddPlantDisplay> {
    return Promise { seal in
      APIService.shared.performRequest(task: GetAvailableDevicesTask()).done { availableDevices in
        seal.fulfill(AddPlantDisplay(availableDevices: availableDevices, plantDetails: PlantDetails.empty))
      }.catch { err in
        print(err.localizedDescription)
        seal.reject(err)
      }
    }
  }

  public func createPlant(from plant: PlantDetails) -> Promise<CreatePlantItem> {
    return Promise { seal in
      APIService.shared.performRequest(task: CreatePlantTask(name: plant.name,
                                                             type: plant.type,
                                                             location: plant.location,
                                                             description: plant.description))
      .done { createPlantItem in
        seal.fulfill(createPlantItem)
      }.catch { err in
        print(err.localizedDescription)
        seal.reject(err)
      }
    }
  }

  public func uploadPlantImage(plantId: String, imageData: Data) -> Promise<UploadPlantImageItem> {
    return Promise { seal in
      APIService.shared.performMultiplartRequest(task:
                                                  UploadPlantImageTask(plantId: plantId,
                                                                       fileData: imageData))
      .done { uploadPlantImageItem in
        seal.fulfill(uploadPlantImageItem)
      } .catch { err in
        print(err.localizedDescription)
        seal.reject(err)
      }
    }
  }

  public func handleCameraPermission() -> Promise<Void> {
    return Promise { seal in
      let status = AVCaptureDevice.authorizationStatus(for: .video)

      switch status {
      case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
          if granted {
            seal.fulfill(())
          } else {
            seal.reject(NSError(domain: "error", code: 1))
          }
        }
      case .restricted, .denied:
        seal.reject(NSError(domain: "error", code: 1))
      case .authorized:
        seal.fulfill(())
      @unknown default:
        seal.reject(NSError(domain: "error", code: 1))
      }
    }
  }

  // MARK: Navigation

  public func navigateBack() {
    coordinator.navigateBack()
  }

  func showImagePickerSheet(delegate: ImagePickerSheetDelegate) {
    coordinator.showImagePickerSheet(delegate: delegate)
  }

  public func showAddDevice() {
    coordinator.showAddDevice()
  }
}
