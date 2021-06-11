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
        UINavigationBar.appearance().titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light) ]
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
