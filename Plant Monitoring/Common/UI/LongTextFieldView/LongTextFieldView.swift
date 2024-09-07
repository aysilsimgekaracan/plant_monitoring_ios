//
//  LongTextFieldView.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 3.09.2024.
//

import UIKit

public final class LongTextFieldView: UIView, UITextViewDelegate {
  // MARK: IBOutlets

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var borderView: View!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var charCounterLabel: UILabel!

  // MARK: IBInspectible

  @IBInspectable var descriptionText: String? {
    get { descriptionLabel.text }
    set { descriptionLabel.text = newValue?.localized() }
  }

  @IBInspectable var characterLimit: Int = 0

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

    textView.delegate = self
  }

  // MARK: UITextViewDelegate

  public func textViewDidBeginEditing(_ textView: UITextView) {
    borderView.borderColor = Colors.plantMiddleGreen
    borderView.borderWidth = 2
    descriptionLabel.textColor = Colors.plantMiddleGreen
  }

  public func textViewDidEndEditing(_ textView: UITextView) {
    borderView.borderColor = UIColor.systemGray5
    borderView.borderWidth = 1
    descriptionLabel.textColor = UIColor.systemGray2
  }

  public func textViewDidChange(_ textView: UITextView) {
    if characterLimit == 0 {
      charCounterLabel.text = "\(textView.text.count)"
    } else {
      charCounterLabel.text = "\(textView.text.count)/\(characterLimit)"
    }
  }

  public func textView(_ textView: UITextView,
                       shouldChangeTextIn range: NSRange,
                       replacementText text: String) -> Bool {
    guard characterLimit > 0 else {
      return true
    }

    let currentText = textView.text.emptyIfNil
    let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
    return updatedText.count <= characterLimit
  }
}
