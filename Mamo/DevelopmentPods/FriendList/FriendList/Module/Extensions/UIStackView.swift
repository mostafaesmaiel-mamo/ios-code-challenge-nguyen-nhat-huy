//
//  UIStackView.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import UIKit

extension UIStackView {
    
    @discardableResult
    open func withMargins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
}
