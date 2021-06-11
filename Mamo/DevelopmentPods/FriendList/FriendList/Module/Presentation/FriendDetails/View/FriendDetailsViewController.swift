//
//  FriendDetailsViewController.swift
//  FriendList
//
//  Created by Huy Nguyen on 11/06/2021.
//

import Foundation

final class FriendDetailsViewController: ListHeaderController<FriendDetailsItemCell,
                                                              String,
                                                              FriendDetailsHeader>,
                                         UICollectionViewDelegateFlowLayout {
    
    private var viewModel: FriendDetailsViewModel!
    
    static func `init`(with viewModel: FriendDetailsViewModel) -> FriendDetailsViewController {
        let view = FriendDetailsViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: FriendDetailsViewModel) {
        viewModel.friendItemViewModel.observe(on: self) { [weak self] in self?.setupItems($0) }
    }
    
    override func setupHeader(_ header: FriendDetailsHeader) {
        header.cellsHorizontalController.items = [[viewModel.friendItemViewModel.value!]]
    }
    
    // MARK: - Private
    
    private func setupViews() {
        title = viewModel.screenTitle
    }
    
    private func setupItems(_ friendListViewModel: FriendListItemViewModel?) {
        guard let friend = friendListViewModel else {
            return
        }
        items = [
            ["Contact: \(friend.publicName.defaultWithDash())",
             "Id: \(friend.id.defaultWithDash())",
             "Phone or Email: \((friend.value ?? "").defaultWithDash())",
             "Frequent: \(friend.isMamoOrFrequents)",
             "Mamo: \(friend.isMamoOrFrequents)"]
        ]
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendDetailsViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height / 2 - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
