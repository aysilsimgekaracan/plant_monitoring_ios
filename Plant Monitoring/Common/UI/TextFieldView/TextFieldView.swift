//
//  TextFieldView.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 2.09.2024.
//

  import UIKit

  protocol TextFieldViewDelegate: AnyObject {
    func textFieldView(_ textFieldView: TextFieldView, didChangeText text: String)
  }

  public final class TextFieldView: UIView, UITextFieldDelegate {
    // MARK: Properties

    weak var delegate: TextFieldViewDelegate?
    private var validator: TextValidator?
    var validationResult: ValidationResult = .init(isValid: false, errors: []) {
      didSet {
        if validationResult.errors.isEmpty {
          errorLabel.isHidden = true
        } else {
          errorLabel.text = validationResult.errors.first?.localizedErrorDescription
          errorLabel.isHidden = false
        }
      }
    }

    // MARK: IBOutlets

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var borderView: View!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

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
      Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
      addSubview(contentView)
      contentView.frame = self.bounds
      contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

      errorLabel.isHidden = true
      textField.delegate = self
    }

    // MARK: Validator

    public func setValidator(_ validator: TextValidator) {
      self.validator = validator
    }

    public func isValid() -> Bool {
      return validationResult.isValid
    }

    // MARK: Private Helpers

    private func validate(text: String) {
      guard let validator = validator else { return }
      validationResult = validator.validate(text: text)
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

    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
      let currentText = textField.text.emptyIfNil

      guard characterLimit > 0 else {
        validate(text: currentText)
        delegate?.textFieldView(self, didChangeText: currentText)
        return true
      }

      let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

      validate(text: updatedText)
      delegate?.textFieldView(self, didChangeText: updatedText)

      return updatedText.count <= characterLimit
    }
  }
