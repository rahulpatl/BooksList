//
//  Appearance.swift
//  IgniteSolution assignment
//
//  Created by Rahul Patil on 04/04/21.
//

import UIKit

final class Appearance {
  static func setAppearance() {
    UINavigationBar.appearance().barTintColor = UIColor(named: "Theme")
    UINavigationBar.appearance().backgroundColor = UIColor(named: "Theme")
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().isTranslucent = false
  }
}
