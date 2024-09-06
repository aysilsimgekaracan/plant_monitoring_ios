//
//  ImagePickerSheet.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 4.09.2024.
//

import UIKit

protocol ImagePickerSheetDelegate: AnyObject {
  func didTapCamera(_ viewController: ImagePickerSheetViewController)
  func didTapLibrary(_ viewController: ImagePickerSheetViewController)
}

public final class ImagePickerSheetViewController: UIViewController {
  // MARK: IBOutlets

  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var libraryButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!

// MARK: Properties

  var viewModel: ImagePickerSheetViewModel!
  weak var delegate: ImagePickerSheetDelegate?

  // MARK: View's Lifecycle

  init(viewModel: ImagePickerSheetViewModel!) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  // MARK: IBActions

  @IBAction func cameraButtonTapped(_ sender: Any) {
    dismiss(animated: true) {
      self.delegate?.didTapCamera(self)
    }
  }

  @IBAction func libraryButtonTapped(_ sender: Any) {
    dismiss(animated: true) {
      self.delegate?.didTapLibrary(self)
    }
  }

  @IBAction func cancelButtonTapped(_ sender: Any) {
    dismiss(animated: true)
  }
}
