//
//  DIContainer.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

final class DIContainer {
    
    private let dependencies: ModuleDependencies
    
    init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeFetchFriendListUseCase() -> FetchFriendsFrequentUseCase {
        return DefaultFetchFriendsFrequentUseCase(friendListRepository: makeFriendListRepository())
    }
    
    func makeSearchFriendUseCase() -> SearchFriendUseCase {
        return DefaultSearchFriendUseCase(friendListRepository: makeFriendListRepository())
    }
    
    // MARK: - Repositories
    func makeFriendListRepository() -> FriendListRepository {
        return DefaultFriendListRepository(apiDataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Friend List
    func makeFriendListViewController(actions: FriendListViewModelActions) -> FriendListViewController {
        return FriendListViewController.`init`(with: makeFriendListViewModel(actions: actions))
    }
    
    func makeFriendListViewModel(actions: FriendListViewModelActions) -> FriendListViewModel {
        return DefaultFriendListViewModel(fetchFriendFrequentsUseCase: makeFetchFriendListUseCase(),
                                          searchFriendUseCase: makeSearchFriendUseCase(),
                                          actions: actions)
    }
    
    func makeFriendListFlowCoordinator(navigationController: UINavigationController) -> FriendListFlowCoordinator {
        return FriendListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - Friend Details
    func makeFriendDetailsViewController(friendItemViewModel: FriendListItemViewModel) -> UIViewController {
        return FriendDetailsViewController.`init`(with: makeFriendDetailsViewModel(friendItemViewModel: friendItemViewModel))
    }
    
    func makeFriendDetailsViewModel(friendItemViewModel: FriendListItemViewModel) -> FriendDetailsViewModel {
        return DefaultFriendDetailsViewModel(friendItemViewModel: friendItemViewModel)
    }
}

extension DIContainer: FriendListFlowCoordinatorDependencies {}
