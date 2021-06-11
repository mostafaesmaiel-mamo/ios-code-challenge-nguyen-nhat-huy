//
//  ListCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 04/06/2021.
//

import UIKit

open class ListCell<T>: UICollectionViewCell {
    
    open override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderWidth = 1.5
                self.layer.borderColor = UIColor.purple.cgColor
            } else {
                self.layer.borderWidth = 0
                self.layer.borderColor = UIColor.clear.cgColor
            }
            self.layer.cornerRadius = 10
            self.layer.masksToBounds = true
        }
    }
    
    open var item: T!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    open func setupViews() { }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
}
