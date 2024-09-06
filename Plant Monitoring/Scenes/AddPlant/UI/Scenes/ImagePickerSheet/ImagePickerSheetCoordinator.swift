//
//  ImagePickerSheetCoordinator.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 4.09.2024.
//

import UIKit

public final class ImagePickerSheetCoordinator: Coordinator {
  var navigationController: UINavigationController
  var delegate: ImagePickerSheetDelegate

  init(navigationController: UINavigationController, delegate: ImagePickerSheetDelegate) {
    self.navigationController = navigationController
    self.delegate = delegate
  }

  func start() {
    let storyboard = UIStoryboard(name: "ImagePickerSheet", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(
      withIdentifier: "ImagePickerSheet") as? ImagePickerSheetViewController else {
      fatalError()
    }

    let viewModel = ImagePickerSheetViewModel(coordinator: self)
    viewController.viewModel = viewModel
    viewController.delegate = delegate

    guard let sheet = viewController.sheetPresentationController else { return }

    if #available(iOS 16.0, *) {
      let customDetent = UISheetPresentationController.Detent.custom { _ in
        return 180
      }
      sheet.detents = [customDetent, .medium()]
    } else {
      sheet.detents = [.medium(), .large()]
    }

    sheet.prefersGrabberVisible = true
    navigationController.present(viewController, animated: true)
  }

}
