//
//  UIView+Stacking.swift
//  FriendList
//
//  Created by Huy Nguyen on 01/06/2021.
//

import UIKit

extension UIView {
    
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView],
                            spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill,
                            distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        addSubview(stackView)
        stackView.fillSuperview()
        return stackView
    }
    
    @discardableResult
    open func stack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.vertical, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    @discardableResult
    open func hstack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.horizontal, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
}

extension UIEdgeInsets {
    
    static public func horizontalSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: 0, left: side, bottom: 0, right: side)
    }
    
    static public func verticalSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: 0, bottom: side, right: 0)
    }
    
    static public func allSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }
}
