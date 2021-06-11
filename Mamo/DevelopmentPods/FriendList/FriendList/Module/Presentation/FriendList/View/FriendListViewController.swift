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
    private var searchController = UISearchController(searchResultsController: nil)
    private var isSearching = false
    private let bottomWrapperHeight: CGFloat = 80
    
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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refreshCollectionView), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var nextButtonView: UIView = {
        let buttonHeight: CGFloat = bottomWrapperHeight - 32
        let view = UIView()
        view.backgroundColor = .white
        view.withSize(CGSize(width: self.view.frame.width, height: bottomWrapperHeight))
        view.centerXToSuperview()
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = buttonHeight / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapToGoFriendDetails), for: .touchUpInside)
        button.withSize(CGSize(width: self.view.frame.width - 32, height: buttonHeight))
        button.centerInSuperview()
        return view
    }()
    
    static func `init`(with viewModel: FriendListViewModel) -> FriendListViewController {
        let view = FriendListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to viewModel: FriendListViewModel) {
        viewModel.friendListItemViewModel.observe(on: self) { [weak self] in self?.updateItems($0) }
        viewModel.contactList.observe(on: self) { [weak self] in self?.updateItems($0) }
        viewModel.authorizedContact.observe(on: self) { [weak self] in self?.setupAuthorizeContactView($0) }
        viewModel.selectedHorizontalContact.observe(on: self) { [weak self] in self?.selectVerticalContact($0) }
        viewModel.isSearching.observe(on: self) { [weak self] in self?.setupIsSearching($0) }
    }
    
    override func setupHeader(_ header: FriendListHeader) {
        header.friendListHeaderCellsHorizontalController.collectionView.backgroundColor = .clear
        header.friendListHeaderCellsHorizontalController.bind(to: viewModel)
        header.friendListHeaderCellsHorizontalController.view.addSubview(searchController.searchBar)
    }
}

extension FriendListViewController {
    
    fileprivate func updateItems(_ contacts: [CNContact]) {
        var friendListItemViewModel = [FriendListItemViewModel]()
        contacts.forEach {
            let friend = Friend(id: Friend.Identifier.init(""),
                                key: "",
                                value: "",
                                publicName: "\($0.familyName) \($0.givenName)",
                                isMamoOrFrequents: false,
                                imageData: $0.imageData)
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
    
    fileprivate func setupViews() {
        title = viewModel.screenTitle
        setupSearchController()
        self.view.addSubview(nextButtonView)
        nextButtonView.anchor(.bottom(view.bottomAnchor, constant: 0))
    }
    
    fileprivate func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search name, phone, email"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchController.searchBar.searchTextField.textColor = .white
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        navigationItem.searchController = searchController
    }
    
    fileprivate func setupIsSearching(_ isSearch: Bool) {
        if isSearch {
            collectionView.addSubview(refreshControl)
        } else {
            viewModel.viewDidLoad()
            refreshControl.endRefreshing()
            refreshControl.removeFromSuperview()
        }
        self.isSearching = isSearch
    }
    
    @objc func refreshCollectionView() {
        setupIsSearching(false)
    }
    
    @objc func didTapToGoFriendDetails() {
        guard let selectedIndex = selectedIndexPath else {
            return
        }
        let friendListItemVM = items[selectedIndex.section][selectedIndex.item]
        let friend = Friend(id: friendListItemVM.id,
                            key: friendListItemVM.key,
                            value: friendListItemVM.value,
                            publicName: friendListItemVM.publicName,
                            isMamoOrFrequents: friendListItemVM.isMamoOrFrequents,
                            imageData: friendListItemVM.imageData)
        viewModel.didSelect(friend)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendListViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: section == 0 && !isSearching ? 120 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: bottomWrapperHeight, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0 || isSearching
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && !isSearching {
            return
        }
        self.selectedIndexPath = indexPath
    }
}

extension FriendListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        viewModel.didSearch(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
    }
}
