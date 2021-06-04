//
//  UIView+Layout.swift
//  FriendList
//
//  Created by Huy Nguyen on 04/06/2021.
//

import UIKit

extension UIView {
    
    convenience public init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}
