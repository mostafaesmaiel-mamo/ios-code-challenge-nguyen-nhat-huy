//
//  FriendListViewController.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation
import Contacts
import ContactsUI

final class FriendListViewController: ListHeaderController<FriendListItemCell,
                                                           FriendListItemViewModel,
                                                           FriendListHeader>,
                                      UICollectionViewDelegateFlowLayout {
    
    private var viewModel: FriendListViewModel!
    private var selectedIndexPath: IndexPath?
    
    lazy var containerOpenSettingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.withSize(CGSize(width: view.frame.width - 20, height: 100))
        return stackView
    }()
    
    lazy var openSettingButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 60)))
        button.setTitle("Open Setting", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(openSetting), for: .touchUpInside)
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(text: "This app requires access to Contacts to proceed. Go to Settings to grant access.",
                             textColor: .black,
                             textAlignment: .center,
                             numberOfLines: 0)
        return label
    }()
    
    static func `init`(with viewModel: FriendListViewModel) -> FriendListViewController {
        let view = FriendListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to viewModel: FriendListViewModel) {
        viewModel.friendListItemViewModel.observe(on: self) { [weak self] in self?.updateItems($0) }
        viewModel.contactList.observe(on: self) { [weak self] in self?.updateItems($0) }
        viewModel.authorizedContact.observe(on: self) { [weak self] in self?.setupAuthorizeContactView($0) }
        viewModel.selectedHorizontalContact.observe(on: self) { [weak self] in self?.selectVerticalContact($0) }
    }
    
    override func setupHeader(_ header: FriendListHeader) {
        header.friendListHeaderCellsHorizontalController.collectionView.backgroundColor = .clear
        header.friendListHeaderCellsHorizontalController.bind(to: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: section == 0 ? 156 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

extension FriendListViewController {
    
    fileprivate func updateItems(_ contacts: [CNContact]) {
        var friendListItemViewModel = [FriendListItemViewModel]()
        contacts.forEach {
            let friend = Friend(id: Friend.Identifier.init(""), publicName: "\($0.familyName) \($0.givenName)")
            friendListItemViewModel.append(FriendListItemViewModel(friend: friend))
        }
        self.items.removeAll()
        self.items.append(friendListItemViewModel)
    }
    
    fileprivate func updateItems(_ friendListItemsVMs: [FriendListItemViewModel]) {
        self.items.insert(friendListItemsVMs, at: 0)
    }
    
    fileprivate func setupAuthorizeContactView(_ isGranted: Bool) {
        guard !isGranted else {
            containerOpenSettingStackView.removeFromSuperview()
            return
        }
        
        containerOpenSettingStackView.addArrangedSubview(label)
        containerOpenSettingStackView.addArrangedSubview(openSettingButton)
        self.view.addSubview(containerOpenSettingStackView)
        containerOpenSettingStackView.centerInSuperview()
    }
    
    @objc fileprivate func openSetting() {
        if let settings = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(settings) {
            UIApplication.shared.open(settings)
        }
    }
    
    fileprivate func selectVerticalContact(_ friendListItemViewModel: FriendListItemViewModel?) {
        guard let friendListItemViewModel = friendListItemViewModel,
              let item = self.items.first?.firstIndex(of: friendListItemViewModel) else {
            return
        }
        
        if let selectIndex = selectedIndexPath,
           let selectedCell = collectionView.cellForItem(at: selectIndex) {
            selectedCell.isSelected = false
        }
        
        let indexPath = IndexPath(item: item, section: 0)
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.isSelected = true
        selectedIndexPath = indexPath
    }
}
