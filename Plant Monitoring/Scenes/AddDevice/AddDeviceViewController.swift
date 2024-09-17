//
//  AddDeviceViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 17.09.2024.
//

import UIKit

public final class AddDeviceViewController: UIViewController {
  // MARK: Properties

  var viewModel: AddDeviceViewModel!

  // MARK: View's Lifecycle

  init(viewModel: AddDeviceViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    viewModel.showBack()
  }
}
