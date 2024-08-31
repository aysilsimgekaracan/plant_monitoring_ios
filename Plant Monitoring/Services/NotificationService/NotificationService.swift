//
//  NotificationService.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 7.03.2024.
//

import Foundation
import SwiftMessages

enum NotificationLayout {
  case card
  case centered
  case message
  case statusLine
  case tab
}

enum NotificationTheme {
  case info
  case success
  case warning
  case errorb
}

enum NotificationStyle {
  case top
  case bottom
  case center
}

/// Show notifications to user.
///
/// Built using SwiftMessages
/// Usage
///
/// ```swift
/// NotificationService.shared.showNotification(...)
/// ```
/// Check ``showNotification(layout:theme:title:body:buttonTitle:completion:)`` for detailed explanation.
public final class NotificationService {
  public static var shared = NotificationService()
  public init() {}

  // swiftlint:disable function_body_length
  /// Shows notification
  /// - Parameters:
  ///   - layout: The ``NotificationLayout`` option to use.
  ///   - theme: The ``NotificationTheme`` option to use
  ///   - title:
  ///   - body:
  ///   - buttonTitle:
  ///   - completion: Give action when the button is pressed (if needed)
  func showNotification(layout: NotificationLayout = .message,
                        theme: NotificationTheme = .warning,
                        title: String = "notification.service.error.title".localized(),
                        body: String,
                        buttonTitle: String = "notification.service.button.title".localized(),
                        completion: @escaping () -> Void) {
    let view: MessageView
    let iconStyle: IconStyle = .default
    var shouldShowButton: Bool
    var config = SwiftMessages.Config()

    switch layout {
    case .card:
      view = MessageView.viewFromNib(layout: .cardView)
      shouldShowButton = true
      config.duration = .forever
      config.presentationStyle = .center
      config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
      config.interactiveHide = false
    case .tab:
      view = MessageView.viewFromNib(layout: .tabView)
      shouldShowButton = false
      config.duration = .seconds(seconds: 1)
      config.presentationStyle = .top
      config.interactiveHide = true
    case .statusLine:
      view = MessageView.viewFromNib(layout: .statusLine)
      shouldShowButton = false
      config.duration = .seconds(seconds: 1)
      config.presentationStyle = .top
      config.interactiveHide = false
    case .centered:
      view = MessageView.viewFromNib(layout: .centeredView)
      shouldShowButton = true
      config.duration = .forever
      config.presentationStyle = .center
      config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
      config.interactiveHide = false
    case .message:
      view = MessageView.viewFromNib(layout: .messageView)
      shouldShowButton = true
      config.duration = .forever
      config.presentationStyle = .bottom
    }

    view.configureContent(title: title,
                          body: body,
                          iconImage: nil,
                          iconText: nil,
                          buttonImage: nil,
                          buttonTitle: buttonTitle,
                          buttonTapHandler: { _ in
      SwiftMessages.hideAll()
      completion()})
    view.configureDropShadow()

    switch theme {
    case .info:
      view.configureTheme(.info, iconStyle: iconStyle)
      view.accessibilityPrefix = "info"
    case .success:
      view.configureTheme(.success, iconStyle: iconStyle)
      view.accessibilityPrefix = "success"
    case .warning:
      view.configureTheme(.warning, iconStyle: iconStyle)
      view.accessibilityPrefix = "warning"
    case .errorb:
      view.configureTheme(.error, iconStyle: iconStyle)
      view.accessibilityPrefix = "error"
    }

    if !shouldShowButton {
        view.button?.isHidden = true
    }

    SwiftMessages.show(config: config, view: view)
  }
  // swiftlint:enable function_body_length
}
