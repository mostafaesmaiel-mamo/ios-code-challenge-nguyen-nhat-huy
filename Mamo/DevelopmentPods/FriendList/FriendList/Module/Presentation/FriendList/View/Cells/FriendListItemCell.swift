//
//  FriendListItemCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

final class FriendListItemCell: ListCell<FriendListItemViewModel> {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel(text: "", font: .monospacedSystemFont(ofSize: 14, weight: .light))
    
    override var item: FriendListItemViewModel! {
        didSet {
            imageView.image = item.publicName.imageWithFirstCharacter()
            nameLabel.text = item.publicName
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        hstack(imageView.withSize(CGSize(width: 60, height: 60)),
               nameLabel,
               spacing: 16,
               alignment: UIStackView.Alignment.center).withMargins(.horizontalSides(16))
        
        imageView.layer.cornerRadius = 60 / 2
        imageView.layer.masksToBounds = true
    }
}
