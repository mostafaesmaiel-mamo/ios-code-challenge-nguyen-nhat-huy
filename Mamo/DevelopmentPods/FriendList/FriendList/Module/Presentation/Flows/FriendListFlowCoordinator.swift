//
//  FriendListFlowCoordinator.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

protocol FriendListFlowCoordinatorDependencies {
    func makeFriendListViewController() -> FriendListViewController
}

final class FriendListFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: FriendListFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController, dependencies: FriendListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = dependencies.makeFriendListViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}
