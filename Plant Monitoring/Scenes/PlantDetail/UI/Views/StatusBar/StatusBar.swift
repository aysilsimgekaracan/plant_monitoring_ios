//
//  StatusBarChart.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 18.04.2024.
//

import UIKit

public final class StatusBar: UIView {

  // MARK: - IBOutlets

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var chartTitleLabel: UILabel!
  @IBOutlet weak var humidityLevelLabel: UILabel!
  @IBOutlet weak var temperatureLevelLabel: UILabel!
  @IBOutlet weak var lightLevelLabel: UILabel!
  @IBOutlet weak var lastUpdateLabel: UILabel!

  // MARK: - Properties

  var firstGradient: UIColor! = .white
  var secondGradient: UIColor! = .white
  var measurementUnit: String! = ""
  var minVal: Double! = 0
  var maxVal: Double! = 100
  var actualVal: Double = 0
  var desiredVal: Double = 0
  var chartTitle: String = ""
  var chartDescription: String = ""

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    Bundle.main.loadNibNamed("StatusBarChart", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth]
  }

  // swiftlint:disable function_parameter_count
  public func configure(
    humidityLevel: String,
    temperatureLevel: String,
    lightLevel: String) {
      humidityLevelLabel.text = humidityLevel
      temperatureLevelLabel.text = temperatureLevel
      lightLevelLabel.text = lightLevel
      lastUpdateLabel.text = "last.update".localized()

  }
  // swiftlint:enable function_parameter_count
}
