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

extension String {
    
    func imageWithFirstCharacter() -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let nameLabel = UILabel(text: nil,
                            font: .boldSystemFont(ofSize: 24),
                            textColor: .white,
                            textAlignment: .center)
        nameLabel.frame = frame
        nameLabel.backgroundColor = .lightGray
        guard let firstChar = self.first else {
            return nil
        }
        nameLabel.text = String(firstChar).capitalized
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
