//
//  FriendListHeaderViewController.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

class FriendListHeaderHorizontalController: ListController<FriendListFrequentsCell, FriendListItemViewModel>,
                                            UICollectionViewDelegateFlowLayout  {
    
    private var viewModel: FriendListViewModel!
    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(to viewModel: FriendListViewModel) {
        self.viewModel = viewModel
        viewModel.friendListItemViewModel.observe(on: self) { [weak self] in self?.updateItems($0) }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: view.frame.height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectIndex = selectedIndexPath {
            collectionView.cellForItem(at: selectIndex)?.isSelected = false
        }
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.isSelected = true
        selectedIndexPath = indexPath
        self.viewModel.selectedHorizontalContact.value = self.items.first?[indexPath.item]
    }
}

extension FriendListHeaderHorizontalController {
    
    fileprivate func updateItems(_ friendListItemsVMs: [FriendListItemViewModel]) {
        self.items.removeAll()
        self.items.append(friendListItemsVMs)
    }
}
