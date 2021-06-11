//
//  FriendListFrequentsCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

final class FriendListFrequentsCell: ListCell<FriendListItemViewModel> {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel(text: "", font: .monospacedSystemFont(ofSize: 12, weight: .light), numberOfLines: 0)
    
    override var item: FriendListItemViewModel! {
        didSet {
            nameLabel.text = item.publicName
            imageView.image = item.publicName.imageWithFirstCharacter()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        let imgWidth: CGFloat = 35
        let stackView = stack(imageView.withSize(CGSize(width: imgWidth, height: imgWidth)),
                              nameLabel,
                              spacing: 16,
                              alignment: UIStackView.Alignment.center)
            .withMargins(.verticalSides(16))
        stackView.backgroundColor = UIColor(red: 243.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        stackView.layer.cornerRadius = 10
        
        imageView.layer.cornerRadius = imgWidth / 2
        imageView.layer.masksToBounds = true
    }
}

final class FriendListHeader: UICollectionReusableView {
    
    let friendListHeaderCellsHorizontalController = FriendListHeaderHorizontalController(scrollDirection: .horizontal)
    private let friendOnMamoLabel = UILabel(text: "Your friend on Mamo", font: .monospacedSystemFont(ofSize: 12, weight: .light), numberOfLines: 0)
    private let yourContactLabel = UILabel(text: "Your contacts", font: .monospacedSystemFont(ofSize: 12, weight: .light), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stack(friendListHeaderCellsHorizontalController.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
