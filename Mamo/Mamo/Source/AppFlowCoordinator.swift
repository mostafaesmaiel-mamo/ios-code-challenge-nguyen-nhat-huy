//
//  AppFlowCoordinator.swift
//  Mamo
//
//  Created by Huy Nguyen on 31/05/2021.
//

import UIKit

final class AppFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        let friendListModule = appDIContainer.makeFriendListModule()
        friendListModule.startFriendListFlow(in: navigationController)
    }
}
