//
//  UIResponder+Additions.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 4.09.2024.
//

import UIKit

extension UIResponder {

    static weak var responder: UIResponder?

    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }

    @objc private func trap() {
        UIResponder.responder = self
    }
}
