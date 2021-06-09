//
//  FriendListFlowCoordinator.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

protocol FriendListFlowCoordinatorDependencies {
    func makeFriendListViewController(actions: FriendListViewModelActions) -> FriendListViewController
}

final class FriendListFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: FriendListFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController, dependencies: FriendListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = FriendListViewModelActions(showFriendDetails: showFriendDetails,
                                                 showFriendQueriesSuggestions: showFriendQueriesSuggestions,
                                                 closeFriendQueriesSuggestions: closeFriendQueriesSuggestions)
        let viewController = dependencies.makeFriendListViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    private func showFriendDetails(friend: Friend) {
        
    }

    private func showFriendQueriesSuggestions(didSelect: @escaping (FriendQuery) -> Void) {
        
    }

    private func closeFriendQueriesSuggestions() {
    }
}
