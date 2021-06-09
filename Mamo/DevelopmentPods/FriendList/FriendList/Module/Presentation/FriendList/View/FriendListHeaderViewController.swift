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
    }
    
    func bind(to viewModel: FriendListViewModel) {
        viewModel.friendListItemViewModel.observe(on: self) { [weak self] in self?.updateItems($0) }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: view.frame.height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 8, bottom: 0, right: 8)
    }
}

extension FriendListHeaderHorizontalController {
    
    fileprivate func updateItems(_ friendListItemsVM: [FriendListItemViewModel]) {
        self.items.append(friendListItemsVM)
    }
}
