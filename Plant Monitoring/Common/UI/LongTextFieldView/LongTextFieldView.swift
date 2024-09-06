//
//  LongTextFieldView.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 3.09.2024.
//

import UIKit

public final class LongTextFieldView: UIView {
  // MARK: IBOutlets

  @IBOutlet var contentView: UIView!

  // MARK: View's Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    Bundle.main.loadNibNamed("LongTextFieldView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
}
