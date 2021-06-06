//
//  FriendListViewController.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

final class FriendListViewController: ListHeaderController<FriendListItemCell, FriendListItemViewModel, FriendListHeader>,
                                      UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [ .init(friend: Friend(id: "1", publicName: "Alexander")),
                  .init(friend: Friend(id: "2", publicName: "Golden")),
                  .init(friend: Friend(id: "3", publicName: "Frank")),
                  .init(friend: Friend(id: "4", publicName: "Red Airship")),
                  .init(friend: Friend(id: "5", publicName: "Devince")),
                  .init(friend: Friend(id: "6", publicName: "Caslos")),
                  .init(friend: Friend(id: "7", publicName: "Benjamin Tran"))]
    }
    
    override func setupHeader(_ header: FriendListHeader) {
        header.friendListHeaderCellsHorizontalController.collectionView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 164)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
