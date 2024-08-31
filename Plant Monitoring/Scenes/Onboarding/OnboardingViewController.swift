//
//  OnboardingViewController.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 22.08.2024.
//

import UIKit

public final class OnboardingViewController: UIViewController {
  // MARK: IBOutlets

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pager: UIPageControl!
  @IBOutlet weak var skipButton: Button!
  @IBOutlet weak var nextButton: Button!

  // MARK: Properties

  var viewModel: OnboardingViewModel!
  var currentPage: Int = 0 {
    didSet {
      pager.currentPage = currentPage
      prepareStep(for: currentPage)
    }
  }
  var display: OnboardingDisplay! = .empty {
    didSet {
      collectionView.reloadData()
      currentPage = .zero
    }
  }

  // MARK: View's Lifecycle

  init(viewModel: OnboardingViewModel!) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    prepareView()

    viewModel.start().done { display in
      self.display = display
    }.catch { error in
      NotificationService.shared.showNotification(body: error.localizedDescription, completion: {})
    }
  }

  // MARK: Actions

  @objc func pageControlChanged(_ sender: UIPageControl) {
    collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: .zero),
                                at: .centeredHorizontally,
                                animated: true)
  }

  @IBAction func nextButtonPressed(_ sender: Any) {
    if currentPage == display.onboardings.count - 1 {
      viewModel.startTabBar()
    } else {
      let nextPage = currentPage + 1
      collectionView.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: .centeredHorizontally, animated: true)
      currentPage = nextPage
    }
  }

  @IBAction func skipButtonPressed(_ sender: Any) {
    viewModel.startTabBar()
  }

  // MARK: Private Helpers

  private func prepareStep(for index: Int) {
    if index == display.onboardings.count - 1 {
      UIView.animate(withDuration: 0.3) {
        self.nextButton.setTitle("onboarding.get.started".localized().uppercased(), for: .normal)
        self.pager.isHidden = true
        self.skipButton.isHidden = true
      }
    } else {
      UIView.animate(withDuration: 0.3) {
        self.nextButton.setTitle("onboarding.next".localized().uppercased(), for: .normal)
        self.skipButton.isHidden = false
        self.pager.isHidden = false
      }
    }
  }

  private func prepareView() {
    // Prepare Collection View
    let nib = UINib(nibName: "OnboardingCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "OnboardingCell")

    collectionView.delegate = self
    collectionView.dataSource = self

    // Prepare Page Control
    pager.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
  }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return display.onboardings.count
  }

  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell",
      for: indexPath) as? OnboardingCell else {
      fatalError("The dequeued cell is not an instance of OnboardingCell")
    }

    cell.configure(with: display.onboardings[indexPath.row])
    return cell
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
  }

  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentCell = Int(scrollView.contentOffset.x / self.collectionView.frame.width)
    self.currentPage = currentCell
  }
}
