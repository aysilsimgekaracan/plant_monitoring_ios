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
  case error
}

enum NotificationStyle {
  case top
  case bottom
  case center
}

public final class NotificationService {
  public static var shared = NotificationService()
  public init() {}

  @MainActor func showNotification(layout: NotificationLayout, theme: NotificationTheme, title: String, body: String, buttonTitle: String) {
    let view: MessageView
    let iconStyle: IconStyle = .default
    var isHapticOn = false
    var isDropShadowOn = true
    var shouldShowButton: Bool
    var config = SwiftMessages.Config()

    switch layout {
    case .card:
      view = MessageView.viewFromNib(layout: .cardView)
      isHapticOn = false
      shouldShowButton = true
      config.duration = .forever
      config.presentationStyle = .center
      config.dimMode = .blur(style: .dark, alpha: 1.0, interactive: true)
    case .tab:
      view = MessageView.viewFromNib(layout: .tabView)
      isHapticOn = true
      shouldShowButton = false
      config.duration = .seconds(seconds: 1)
      config.presentationStyle = .top
      config.interactiveHide = true
    case .statusLine:
      view = MessageView.viewFromNib(layout: .statusLine)
      isHapticOn = false
      shouldShowButton = false
      config.duration = .seconds(seconds: 1)
      config.presentationStyle = .top
    case .centered:
      view = MessageView.viewFromNib(layout: .centeredView)
      isHapticOn = false
      shouldShowButton = true
      config.duration = .forever
      config.presentationStyle = .center
      config.dimMode = .blur(style: .dark, alpha: 1.0, interactive: true)
    case .message:
      view = MessageView.viewFromNib(layout: .messageView)
      isHapticOn = false
      shouldShowButton = true
      config.duration = .forever
      config.presentationStyle = .center
      config.dimMode = .blur(style: .dark, alpha: 1.0, interactive: true)
    }
    
    view.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: buttonTitle, buttonTapHandler: {_ in
      SwiftMessages.hideAll()})

    switch theme {
    case .info:
      view.configureTheme(.info, iconStyle: iconStyle, includeHaptic: isHapticOn)
      view.accessibilityPrefix = "info"
    case .success:
      view.configureTheme(.success, iconStyle: iconStyle, includeHaptic: isHapticOn)
      view.accessibilityPrefix = "success"
    case .warning:
      view.configureTheme(.warning, iconStyle: iconStyle, includeHaptic: isHapticOn)
      view.accessibilityPrefix = "warning"
    case .error:
      view.configureTheme(.error, iconStyle: iconStyle, includeHaptic: isHapticOn)
      view.accessibilityPrefix = "error"
    }

    if isDropShadowOn {
        view.configureDropShadow()
    }

    if !shouldShowButton {
        view.button?.isHidden = true
    }
    
    if view.defaultHaptic == nil && isHapticOn {
        config.haptic = .success
    }

    SwiftMessages.show(config: config, view: view)
  }

}

