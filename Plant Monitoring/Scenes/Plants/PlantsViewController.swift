//
//  PlantsViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.03.2024.
//

import UIKit

public final class PlantsViewController: UIViewController {

  var viewModel: PlantsViewModel!

  // MARK: - View Lifecycle

  init(viewModel: PlantsViewModel!) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
