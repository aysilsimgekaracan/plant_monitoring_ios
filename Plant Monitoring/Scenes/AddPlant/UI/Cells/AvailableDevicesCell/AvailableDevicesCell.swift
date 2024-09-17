//
//  DevicesCell.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 7.09.2024.
//

import UIKit

protocol AvailableDevicesCellDelegate: AnyObject {
  func didTapAddANewDevice(_ cell: UICollectionViewCell)
}

private struct Constants {
  public static let cellWitdh: CGFloat = 128
  public static let cellHeight: CGFloat = 128
  public static let minimumInteritemSpacing: Int = 10
  public static let minimumLineSpacingForSections: CGFloat = 10
}

public final class AvailableDevicesCell: UICollectionViewCell,
                                         UICollectionViewDelegate,
                                         UICollectionViewDataSource,
                                         UICollectionViewDelegateFlowLayout {
  // MARK: Properties

  weak var delegate: AvailableDevicesCellDelegate?
  var availableDevices: [AvailableDeviceItem] = [] {
    didSet {
      if availableDevices.isEmpty {
        emptyDeviceStackView.isHidden = false
        availableDevicesStackView.isHidden = true
      } else {
        availableDevicesStackView.isHidden = false
        emptyDeviceStackView.isHidden = true
        collectionView.reloadData()
      }
    }
  }

  // MARK: IBOutlets

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var availableDevicesStackView: UIStackView!
  @IBOutlet weak var emptyDeviceStackView: UIStackView!

  // MARK: Lifecylce

  public override func awakeFromNib() {
    super.awakeFromNib()
    prepareView()
  }

  private func prepareView() {
    let nib = UINib(nibName: "DevicesCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "DevicesCell")

    collectionView.delegate = self
    collectionView.dataSource = self
    emptyDeviceStackView.isHidden = true
  }

  public func configure(with availableDevices: [AvailableDeviceItem]) {
    self.availableDevices = availableDevices
  }

  // MARK: IBActions

  @IBAction func addANewDeviceButtonPressed(_ sender: Any) {
    delegate?.didTapAddANewDevice(self)
  }

  // MARK: UICollectionViewDelegate, UICollectionViewDataSource

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return availableDevices.count
  }

  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DevicesCell",
                                                        for: indexPath) as? DevicesCell else {
      fatalError("The dequeued cell is not an instance of DevicesCell")
    }
    cell.configure(with: availableDevices[indexPath.row])
    return cell
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    let availableWidth = collectionView.frame.width
    let minimumCellWidth: CGFloat = Constants.cellWitdh
    let numberOfItemsPerRow = max(Int(availableWidth /
                                      (minimumCellWidth + CGFloat(Constants.minimumInteritemSpacing))), 1)

    let totalSpacing = CGFloat(Constants.minimumInteritemSpacing) * CGFloat(numberOfItemsPerRow - 1)
    let cellWidth = (availableWidth - totalSpacing) / CGFloat(numberOfItemsPerRow)

    return CGSize(width: cellWidth, height: Constants.cellHeight)
      }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return CGFloat(Constants.minimumInteritemSpacing)
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.minimumLineSpacingForSections
  }

  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let cell = collectionView.cellForItem(at: indexPath) as? DevicesCell {
      cell.highlightSelectedCell()
    }
  }

  public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if let cell = collectionView.cellForItem(at: indexPath) as? DevicesCell {
      cell.unhighlightDeselectedCell()
    }
  }
}
