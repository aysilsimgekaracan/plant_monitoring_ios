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
}
