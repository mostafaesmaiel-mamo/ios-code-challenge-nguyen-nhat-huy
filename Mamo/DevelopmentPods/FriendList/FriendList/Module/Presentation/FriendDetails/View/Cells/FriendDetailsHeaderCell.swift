//
//  FriendDetailsHeaderCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 11/06/2021.
//

import Foundation

final class FriendDetailsHeader: UICollectionReusableView {
    
    final class FriendDetailsHeaderCell: ListCell<FriendListItemViewModel> {
        
        private let imageView = UIImageView()
        private let nameLabel = UILabel(text: "", font: .monospacedSystemFont(ofSize: 12, weight: .light), numberOfLines: 2)
        
        override var item: FriendListItemViewModel! {
            didSet {
                nameLabel.text = item.publicName
                nameLabel.textAlignment = .center
                guard let imageData = item.imageData,
                      let image = UIImage(data: imageData) else {
                    imageView.image = item.publicName.imageWithFirstCharacter()
                    return
                }
                imageView.image = image
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
    
    class FriendDetailsHeaderController: ListController<FriendDetailsHeaderCell, FriendListItemViewModel>, UICollectionViewDelegateFlowLayout  {
        
        let itemWidth: CGFloat = 80
        let itemHeight: CGFloat = 120
            
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return .init(width: itemWidth, height: itemHeight)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return .init(top: view.center.y - (itemHeight / 2), left: view.center.x - (itemWidth / 2), bottom: 0, right: 8)
        }
    }
    
    let cellsHorizontalController = FriendDetailsHeaderController(scrollDirection: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stack(cellsHorizontalController.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
