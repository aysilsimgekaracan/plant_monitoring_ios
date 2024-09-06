//
//  AddPlantViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 2.09.2024.
//

import UIKit
import PhotosUI

private enum CellTypes: Int, CaseIterable {
  case addPlantCell = 0
  case selectDeviceCell = 1
}

public final class AddPlantViewController: UIViewController {
  // MARK: IBOutlets

  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: Properties

  var viewModel: AddPlantViewModel!
  var display: AddPlantDisplay = .empty

  // MARK: View's Lifecycle

  init(viewModel: AddPlantViewModel!) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.addKeyboardObserver()
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    prepareCollectionView()
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.removeKeyboardObserver()
  }

  // MARK: Private Helpers

  private func prepareCollectionView() {
    let nib = UINib(nibName: "AddPlantCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "AddPlantCell")

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func showCamera() {
    let viewController = UIImagePickerController()
    viewController.sourceType = .camera
    viewController.allowsEditing = true
    viewController.delegate = self
    present(viewController, animated: true)
  }

  private func showPhotoLibrary() {
    var configuration = PHPickerConfiguration()
    configuration.filter = .images
    configuration.selectionLimit = 1
    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension AddPlantViewController: UICollectionViewDelegate,
                                  UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return CellTypes.allCases.count
  }

  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlantCell",
                                                        for: indexPath) as? AddPlantCell else {
      fatalError("The dequeued cell is not an instance of AddPlantCell")
    }
    cell.delegate = self
    cell.configure()
    return cell
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
  }
}

// MARK: AddPlantCellDelegate

extension AddPlantViewController: AddPlantCellDelegate {
  func didTapImage(_ cell: AddPlantCell) {
    viewModel.showImagePickerSheet(delegate: self)
  }
}

// MARK: ImagePickerSheetDelegate

extension AddPlantViewController: ImagePickerSheetDelegate {
  func didTapCamera(_ viewController: ImagePickerSheetViewController) {
    viewModel.handleCameraPermission().done { _ in
      self.showCamera()
    }.catch { _ in
      NotificationService.shared.showNotification(layout: .centered,
                                                  theme: .info,
                                                  title: self.display.cameraDeniedTitle,
                                                  body: self.display.cameraDeniedDescription) { }
    }
  }

  func didTapLibrary(_ viewController: ImagePickerSheetViewController) {
    showPhotoLibrary()
  }
}

// MARK: UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension AddPlantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  public func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    picker.dismiss(animated: true)

    guard let image = info[.editedImage] as? UIImage else {
      return
    }

    let indexPath = IndexPath(item: CellTypes.addPlantCell.rawValue, section: .zero)
    if let cell = collectionView.cellForItem(at: indexPath) as? AddPlantCell {
      cell.updateImage(with: image)
    }
  }
}

// MARK: PHPickerViewControllerDelegate

extension AddPlantViewController: PHPickerViewControllerDelegate {
  public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)

    if let itemProvider = results.first?.itemProvider {
      if itemProvider.canLoadObject(ofClass: UIImage.self) {
        itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
          if let error {
            NotificationService.shared.showNotification(layout: .centered,
                                                        theme: .info,
                                                        title: self.display.libraryDeniedTitle,
                                                        body: error.localizedDescription) { }
          }

          if let selectedImage = image as? UIImage {
            DispatchQueue.main.async {
              let indexPath = IndexPath(item: CellTypes.addPlantCell.rawValue, section: .zero)
              if let cell = self.collectionView.cellForItem(at: indexPath) as? AddPlantCell {
                cell.updateImage(with: selectedImage)
              }
            }
          }
        }
      }
    }
  }
}
