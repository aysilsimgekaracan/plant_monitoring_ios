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
  case availableDevicesCell = 1
}

public final class AddPlantViewController: UIViewController {
  // MARK: IBOutlets

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pager: UIPageControl!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var completionButton: UIButton!

  // MARK: Properties

  var viewModel: AddPlantViewModel!
  var display: AddPlantDisplay = .empty
  var currentPage: Int = .zero {
    didSet {
      pager.currentPage = currentPage
      prepareStep(for: currentPage)
    }
  }

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

    viewModel.start().done { [weak self] display in
      self?.display = display
    }.catch { err in
      NotificationService.shared.showNotification(body: err.localizedDescription) { }
    }

    self.prepareView()
    self.prepareCollectionView()
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.removeKeyboardObserver()
  }

  // MARK: IBActions

  @IBAction func navigateBackButtonPressed(_ sender: Any) {
    viewModel.navigateBack()
  }

  @IBAction func completionButtonPressed(_ sender: Any) {
    if currentPage == CellTypes.allCases.count - 1 {
      // TODO: continue next step
    } else {
      if let visibleCells = collectionView.visibleCells as? [AddPlantCell] {
        for cell in visibleCells {
          display.plantDetails = cell.getPlantDetails()
        }
        if !display.plantDetails.isValid {
          NotificationService.shared.showNotification(body: "validation.general.error".localized()) { }
        } else {
          let nextPage = currentPage + 1
          collectionView.scrollToItem(at: IndexPath(item: nextPage,
                                                  section: 0),
                                      at: .centeredHorizontally,
                                      animated: true)
          currentPage = nextPage
          if display.availableDevices.isEmpty {
            completionButton.isHidden = true
          }
        }
      }
    }
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    if currentPage != .zero {
      let nextPage = currentPage - 1
      collectionView.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: .centeredHorizontally, animated: true)
      currentPage = nextPage
      completionButton.isHidden = false
    }

  }

  // MARK: Private Helpers

  private func prepareCollectionView() {
    let addPlantNib = UINib(nibName: "AddPlantCell", bundle: nil)
    collectionView.register(addPlantNib, forCellWithReuseIdentifier: "AddPlantCell")

    let availableDevicesNib = UINib(nibName: "AvailableDevicesCell", bundle: nil)
    collectionView.register(availableDevicesNib, forCellWithReuseIdentifier: "AvailableDevicesCell")

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func prepareView() {
    backButton.isHidden = true
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

  private func prepareStep(for index: Int) {
    backButton.isHidden = index == 0
  }

  private func showSuccessMessageAndNavigateToAddDevice() {
    NotificationService.shared.showNotification(layout: .message,
                                                theme: .success,
                                                title: "add.plant.success.title".localized(),
                                                body: "add.plant.success.add.device.body".localized()) {
      self.viewModel.showAddDevice()
    }
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

    switch indexPath.row {
    case CellTypes.addPlantCell.rawValue:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlantCell",
                                                          for: indexPath) as? AddPlantCell else {
        fatalError("The dequeued cell is not an instance of AddPlantCell")
      }
      cell.delegate = self
      cell.configure()
      return cell
    case CellTypes.availableDevicesCell.rawValue:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailableDevicesCell",
                                                          for: indexPath) as? AvailableDevicesCell else {
        fatalError("The dequeued cell is not an instance of AvailableDevicesCell")
      }
      cell.configure(with: display.availableDevices)
      cell.delegate = self
      return cell

    default:
      return UICollectionViewCell()
    }
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
    display.plantImage = image

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
            self.display.plantImage = selectedImage
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

// MARK: AvailableDevicesCellDelegate

extension AddPlantViewController: AvailableDevicesCellDelegate {
  func didTapAddANewDevice(_ cell: UICollectionViewCell) {
    showLoadingIndicator()
    viewModel.createPlant(from: display.plantDetails).done { [weak self] createPlantItem in
      guard let self = self else { return }
      if let image = self.display.plantImage {

        let targertSize = CGSize(width: 800, height: 600)
        let resizedImage = image.resizedImage(to: targertSize)

        if let imageData = resizedImage.jpegData(compressionQuality: 0.7) {
          self.viewModel.uploadPlantImage(plantId: createPlantItem.id, imageData: imageData).done { [weak self] _ in
            self?.hideLoadingIndicator()
            self?.showSuccessMessageAndNavigateToAddDevice()
          }.catch { [weak self] error in
            self?.hideLoadingIndicator()
            NotificationService.shared.showNotification(body: error.localizedDescription) {}
          }
        }
      } else {
        self.hideLoadingIndicator()
        self.showSuccessMessageAndNavigateToAddDevice()
      }
    }.catch { [weak self] error in
      self?.hideLoadingIndicator()
      NotificationService.shared.showNotification(body: error.localizedDescription) {}
    }
  }
}
