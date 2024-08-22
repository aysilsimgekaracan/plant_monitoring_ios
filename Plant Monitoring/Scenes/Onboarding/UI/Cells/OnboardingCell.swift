//
//  OnboardingCell.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 22.08.2024.
//

import UIKit

public final class OnboardingCell: UICollectionViewCell {

  @IBOutlet weak var iconImage: UIImageView!

  public func configure(with onboarding: OnboardingItem) {
    let image = UIImage(named: onboarding.imageName)
    iconImage.image = image
  }
}
