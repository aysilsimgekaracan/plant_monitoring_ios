//
//  AddPlantCell.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 2.09.2024.
//

import UIKit

protocol AddPlantCellDelegate: AnyObject {
  func didTapImage(_ cell: AddPlantCell)
}

public final class AddPlantCell: UICollectionViewCell {
  weak var delegate: AddPlantCellDelegate?

  @IBOutlet weak var imageView: UIImageView!

  public func configure() {
    prepareView()
  }

  public func updateImage(with image: UIImage) {
    imageView.image = image
  }

  private func prepareView() {
    // Add tap gesture recognizer to the  imageView
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    imageView.addGestureRecognizer(tapGestureRecognizer)
  }

  @objc func imageTapped() {
    delegate?.didTapImage(self)
  }
}
