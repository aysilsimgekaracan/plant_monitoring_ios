//
//  DevicesCell.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 7.09.2024.
//

import UIKit

public final class DevicesCell: UICollectionViewCell {

  @IBOutlet weak var deviceNameLabel: UILabel!
  @IBOutlet weak var deviceIDLabel: UILabel!

  public func configure(deviceName: String, deviceID: String) {
    deviceNameLabel.text = deviceName
    deviceIDLabel.text = "ID: \(deviceID)"
  }
}
