//
//  ValidationService.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 17.09.2024.
//

import Foundation

public final class ValidationService {
  static let shared = ValidationService()

  var defaultValidator: TextValidator {
    return TextValidator()
      .minLength(5)
      .maxLength(20)
    }
  var minLenghtFiveMaxLengthTwentyValidator: TextValidator {
    return TextValidator()
      .minLength(5)
      .maxLength(20)
  }
}
