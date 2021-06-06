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
    
    func makeFriendListViewController() -> FriendListViewController {
        return FriendListViewController()
    }
    
    func makeFriendListFlowCoordinator(navigationController: UINavigationController) -> FriendListFlowCoordinator {
        return FriendListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DIContainer: FriendListFlowCoordinatorDependencies {}
