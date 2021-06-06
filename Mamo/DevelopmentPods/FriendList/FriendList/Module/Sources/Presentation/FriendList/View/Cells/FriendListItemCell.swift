//
//  FriendListItemCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

final class FriendListItemCell: ListCell<FriendListItemViewModel> {
    
    let imageView = UIImageView(image: UIImage(named: "Image"))
    let nameLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 14))
    
    override var item: FriendListItemViewModel! {
        didSet {
            nameLabel.text = item.publicName
        }
    }
    
    override func setupViews() {
        super.setupViews()
        stack(imageView, nameLabel, spacing: 16)
    }
}
