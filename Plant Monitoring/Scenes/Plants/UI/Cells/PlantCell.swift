//
//  PlantCell.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.04.2024.
//

import UIKit

public final class PlantCell: UITableViewCell {

  @IBOutlet weak var plantImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var plantDescription: UILabel!

  public func configure(with plant: PlantItem) {
    nameLabel.text = plant.name
    locationLabel.text = plant.location
    typeLabel.text = plant.type
    plantDescription.text = plant.description
  }

}
