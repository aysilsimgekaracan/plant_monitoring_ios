//
//  HomeViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 28.01.2024.
//

import UIKit

public final class HomeViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var tableView: UITableView!

  // MARK: - Properties

  var viewModel: HomeViewModel!
  var display: HomeDisplay!

  private enum TableViewCellType: Int, CaseIterable {
    case plantTrackCard = 0
  }

  // MARK: - View Lifecycle

  init(viewModel: HomeViewModel) {
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

  // MARK: - Prepare View
  private func prepareTableView() {
    tableView.delegate = self
    tableView.dataSource = self

    tableView.register(
      UINib(nibName: "EmptyPlantTrackCard", bundle: nil),
      forCellReuseIdentifier: "EmptyPlantTrackCard")
  }
}

// MARK: - TableView - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    TableViewCellType.allCases.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case TableViewCellType.plantTrackCard.rawValue:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "EmptyPlantTrackCard",
        for: indexPath) as? EmptyPlantTrackCard else {
        fatalError("Failed to dequeue reusable cell EmptyPlantTrackCard")
      }

      return cell
    default:
      fatalError()
    }
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let spacing = 20.0
    var height = 0.0

    switch indexPath.row {
    case TableViewCellType.plantTrackCard.rawValue:
      height = 100
    default:
      height = 0
    }
    return height + spacing
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? EmptyPlantTrackCard {
      cell.contentStackView.animateTappedEffect()
      viewModel.showPlants()
    }
  }

}
