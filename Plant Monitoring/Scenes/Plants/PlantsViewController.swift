//
//  PlantsViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.03.2024.
//

import UIKit

public final class PlantsViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var tableView: UITableView!

  // MARK: - Properties

  var viewModel: PlantsViewModel!
  private var refreshControl = UIRefreshControl()
  var plants: [PlantItem] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  // MARK: - View Lifecycle

  init(viewModel: PlantsViewModel!) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    prepareTableView()
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    showLoadingIndicator()
    start()
  }

  // MARK: IBActions

  @IBAction func addPlantButtonPressed(_ sender: Any) {
    viewModel.showAddPlant()
  }

  // MARK: - Private Helpers

  private func start() {
    viewModel.getPlants().done { plants in
      self.plants = plants
      self.hideLoadingIndicator()
    }.catch { err in
      NotificationService.shared.showNotification(
        layout: .message,
        theme: .warning, title: "notification.service.error.title".localized(),
        body: err.localizedDescription,
        buttonTitle: "notification.service.button.title".localized(),
        completion: { self.start() })
    }
    refreshControl.endRefreshing()
  }

  private func prepareTableView() {
    // Set up the table view
    tableView.delegate = self
    tableView.dataSource = self

    tableView.register(
      UINib(nibName: "PlantCell", bundle: nil),
      forCellReuseIdentifier: "PlantCell")

    // Configure the refresh control
    refreshControl.addAction(UIAction { [weak self] _ in
      self?.start()
    }, for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
}

// MARK: - TableView - UITableViewDelegate, UITableViewDataSource

extension PlantsViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    plants.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as? PlantCell else {
      fatalError("Failed to dequeue reusable cell PlantCell")
    }

    cell.configure(with: plants[indexPath.row])

    return cell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? PlantCell else { return }
    cell.animateTappedEffect()

    viewModel.showPlantDetail(for: plants[indexPath.row])
  }

}
