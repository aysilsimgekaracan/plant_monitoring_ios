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
  @IBOutlet weak var borderView: View!

  public func configure(deviceName: String, deviceID: String) {
    deviceNameLabel.text = deviceName
    deviceIDLabel.text = "ID: \(deviceID)"
  }

  public func configure(with availableDevice: AvailableDeviceItem) {
    deviceNameLabel.text = availableDevice.deviceName
    deviceIDLabel.text = availableDevice.serialNumber
  }

  public func highlightSelectedCell() {
    borderView.backgroundColor = Colors.plantCrystalGreen
  }

  public func unhighlightDeselectedCell() {
    borderView.backgroundColor = Colors.plantCream
  }
}
