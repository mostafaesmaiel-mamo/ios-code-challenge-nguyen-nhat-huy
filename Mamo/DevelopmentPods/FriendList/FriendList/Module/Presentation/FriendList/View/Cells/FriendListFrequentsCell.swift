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
            imageView.image = item.publicName.imageWithFirstCharacter()
            nameLabel.text = item.publicName
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
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = 10
        
        imageView.layer.cornerRadius = imgWidth / 2
        imageView.layer.masksToBounds = true
    }
}

final class FriendListHeader: UICollectionReusableView {
    
    private let friendFrequentLabel = UILabel(text: "Frequents", font: .monospacedSystemFont(ofSize: 12, weight: .light), numberOfLines: 0)
    
    let friendListHeaderCellsHorizontalController = FriendListHeaderHorizontalController(scrollDirection: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard frame.size.height < 164 else {
            stack(yourContactsLabel)
            return
        }
        
        stack(friendFrequentLabel,
              stack(friendListHeaderCellsHorizontalController.view))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
