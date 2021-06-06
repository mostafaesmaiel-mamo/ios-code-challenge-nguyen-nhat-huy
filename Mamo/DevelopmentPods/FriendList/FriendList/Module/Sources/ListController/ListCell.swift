//
//  ListCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 04/06/2021.
//

import UIKit

open class ListCell<T>: UICollectionViewCell {
    
    
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
