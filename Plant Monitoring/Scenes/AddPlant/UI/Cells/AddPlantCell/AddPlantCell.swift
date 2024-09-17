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
  private let validator: ValidationService = ValidationService()

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameTextFieldView: TextFieldView!
  @IBOutlet weak var typeTextFieldView: TextFieldView!
  @IBOutlet weak var locationTextFieldView: TextFieldView!
  @IBOutlet weak var descriptionLongTextFieldView: LongTextFieldView!

  public func configure() {
    prepareView()
  }

  public func updateImage(with image: UIImage) {
    imageView.image = image
  }

  public func getPlantDetails() -> PlantDetails {
    let name = nameTextFieldView.textField.text.emptyIfNil
    let type = typeTextFieldView.textField.text.emptyIfNil
    let location = locationTextFieldView.textField.text.emptyIfNil
    let description = descriptionLongTextFieldView.textView.text.emptyIfNil

    let isValid = nameTextFieldView.isValid() && typeTextFieldView.isValid() && locationTextFieldView.isValid()

    return PlantDetails(name: name, type: type, location: location, description: description, isValid: isValid)
  }

  private func prepareView() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    imageView.addGestureRecognizer(tapGestureRecognizer)

    // Set Validators
    nameTextFieldView.setValidator(validator.minLenghtFiveMaxLengthTwentyValidator)
    typeTextFieldView.setValidator(validator.minLenghtFiveMaxLengthTwentyValidator)
    locationTextFieldView.setValidator(validator.minLenghtFiveMaxLengthTwentyValidator)
  }

  @objc func imageTapped() {
    delegate?.didTapImage(self)
  }
}
