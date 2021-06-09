//
//  FriendListHeaderViewController.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

class FriendListHeaderHorizontalController: ListController<FriendListFrequentsCell, FriendListItemViewModel>,
                                            UICollectionViewDelegateFlowLayout  {
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [ [.init(friend: Friend(id: "10", publicName: "Nicolas")),
                  .init(friend: Friend(id: "12", publicName: "Phil Jonh")),
                  .init(friend: Friend(id: "13", publicName: "Harry Poster")),
                  .init(friend: Friend(id: "14", publicName: "Lucas Mazques")),
                  .init(friend: Friend(id: "15", publicName: "Onion")),
                  .init(friend: Friend(id: "16", publicName: "Yvels"))]]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: view.frame.height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 8, bottom: 0, right: 8)
    }
}

