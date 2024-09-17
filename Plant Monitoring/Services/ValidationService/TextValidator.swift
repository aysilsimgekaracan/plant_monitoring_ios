//
//  ValidationService.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 17.09.2024.
//

import Foundation

enum ValidationError: Error {
  case tooShort
  case tooLong
  case invalidFormat
  case custom(message: String)

  var localizedErrorDescription: String {
    switch self {
    case .tooShort:
      return "validation.error.too.short".localized()
    case .tooLong:
      return "validation.error.too.long".localized()
    case .invalidFormat:
      return "validation.error.invalid.format".localized()
    case .custom(message: let message):
      return message.localized()
    }
  }
}

struct ValidationResult {
  let isValid: Bool
  let errors: [ValidationError]
}

public final class TextValidator {
  private var validations: [(String) -> ValidationResult] = []

    func minLength(_ length: Int) -> TextValidator {
      validations.append { text in
        if text.count < length {
          return ValidationResult(isValid: false, errors: [.tooShort])
        }
        return ValidationResult(isValid: true, errors: [])
      }
      return self
    }

    func maxLength(_ length: Int) -> TextValidator {
      validations.append { text in
        if text.count > length {
          return ValidationResult(isValid: false, errors: [.tooLong])
        }
        return ValidationResult(isValid: true, errors: [])
      }
      return self
    }

    func matchesRegex(_ regex: String) -> TextValidator {
      validations.append { text in
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: text) {
          return ValidationResult(isValid: false, errors: [.invalidFormat])
        }
        return ValidationResult(isValid: true, errors: [])
      }
      return self
    }

    func addCustomValidation(_ validation: @escaping (String) -> ValidationResult) -> TextValidator {
      validations.append(validation)
      return self
    }

    func validate(text: String) -> ValidationResult {
      var isValid = true
      var allErrors: [ValidationError] = []

      for validation in validations {
        let result = validation(text)
        if !result.isValid {
          isValid = false
          allErrors.append(contentsOf: result.errors)
        }
      }

      return ValidationResult(isValid: isValid, errors: allErrors)
    }
}
