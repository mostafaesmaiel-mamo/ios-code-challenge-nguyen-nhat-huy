//
//  FriendDetailsItemCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 11/06/2021.
//

import Foundation

class FriendDetailsItemCell: ListCell<String> {
    
    let titleLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .light))
    
    override var item: String! {
        didSet {
            titleLabel.text = item
            titleLabel.textAlignment = .center
        }
    }
    
    override func setupViews() {
        super.setupViews()
        stack(titleLabel)
    }
}
