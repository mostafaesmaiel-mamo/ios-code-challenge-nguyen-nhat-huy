//
//  AppAppearance.swift
//  Mamo
//
//  Created by Huy Nguyen on 31/05/2021.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
