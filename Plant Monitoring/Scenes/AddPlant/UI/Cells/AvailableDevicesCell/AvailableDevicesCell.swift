//
//  DevicesCell.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 7.09.2024.
//

import UIKit

private struct Constants {
  public static let cellWitdh: CGFloat = 128
  public static let cellHeight: CGFloat = 128
  public static let numberOfCells: Int = 20
  public static let minimumInteritemSpacing: Int = 10
  public static let minimumLineSpacingForSections: CGFloat = 10
}

public final class AvailableDevicesCell: UICollectionViewCell,
                                         UICollectionViewDelegate,
                                         UICollectionViewDataSource,
                                         UICollectionViewDelegateFlowLayout {
  // MARK: IBOutlets

  @IBOutlet weak var collectionView: UICollectionView!

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
  }

  // MARK: UICollectionViewDelegate, UICollectionViewDataSource

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Constants.numberOfCells
  }

  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DevicesCell",
                                                        for: indexPath) as? DevicesCell else {
      fatalError("The dequeued cell is not an instance of DevicesCell")
    }
    return cell
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    let availableWidth = collectionView.frame.width
    let minimumCellWidth: CGFloat = Constants.cellWitdh
    let numberOfItemsPerRow = max(Int(availableWidth / (minimumCellWidth + CGFloat(Constants.minimumInteritemSpacing))), 1) // Ensure at least 1 item per row

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
}
