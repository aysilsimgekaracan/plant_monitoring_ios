//
//  TextFieldView.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 2.09.2024.
//

import UIKit

public final class TextFieldView: UIView, UITextFieldDelegate {

  // MARK: IBOutlets

  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var borderView: View!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var textField: UITextField!

  // MARK: IBInspectible

  @IBInspectable var descriptionText: String? {
    get { descriptionLabel.text }
    set { descriptionLabel.text = newValue?.localized() }
  }

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
    Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    textField.delegate = self
  }

  // MARK: UITextFieldDelegate

  public func textFieldDidBeginEditing(_ textField: UITextField) {
    borderView.borderColor = Colors.plantMiddleGreen
    borderView.borderWidth = 2
    descriptionLabel.textColor = Colors.plantMiddleGreen
  }

  public func textFieldDidEndEditing(_ textField: UITextField) {
    borderView.borderColor = UIColor.systemGray5
    borderView.borderWidth = 1
    descriptionLabel.textColor = UIColor.systemGray2
  }
}
