//
//  PlantDetailViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 16.04.2024.
//

import UIKit

public final class PlantDetailViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var plantTitleLabel: UILabel!
  @IBOutlet weak var plantLocationTitle: UILabel!
  @IBOutlet weak var plantTypeTitle: UILabel!
  @IBOutlet weak var plantDescriptionTitle: UITextView!
  @IBOutlet weak var statusStackView: UIStackView!
  @IBOutlet weak var currentStatusBar: StatusBar!

  // MARK: - Properties

  var viewModel: PlantDetailViewModel!

  // MARK: - View Lifecycle

  init(viewModel: PlantDetailViewModel!) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    prepareView()
  }

  // MARK: - IBActions

  @IBAction func back(_ sender: Any) {
    viewModel.navigateBack()
  }

  // MARK: - Helpers

  private func prepareView() {
    plantTitleLabel.text = viewModel.plant.name
    plantLocationTitle.text = viewModel.plant.location
    plantTypeTitle.text = viewModel.plant.type
    plantDescriptionTitle.text = viewModel.plant.description

    currentStatusBar.configure(humidityLevel: "70", temperatureLevel: "25", lightLevel: "3")

  }
}
