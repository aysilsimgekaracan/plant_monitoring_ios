//
//  Colors.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 5.03.2024.
//

import UIKit
/// Use Colors struct to access custom colors programmatically.
///
/// When you want to add a new color, add color to Assets catalog and define the color in there.
///
/// ```swift
/// public static let newColor = UIColor(named: "newColor")
/// ```
///
/// Use programatically when needed:
///
/// ```swift
/// Colors.newColor
/// ```

public struct Colors {
  public static let plantCrystalGreen = UIColor(named: "plant-crystal-green")!
  public static let plantLightPastelPurple = UIColor(named: "plant-light-pastel-purple")!
  public static let plantDeepMossGreen = UIColor(named: "plant-deep-moss-green")!
  public static let plantMiddleGreen = UIColor(named: "plant-middle-green")!
}
