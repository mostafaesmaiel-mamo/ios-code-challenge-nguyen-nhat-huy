//
//  Module.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

public struct ModuleDependencies {
    
    let apiDataTransferService: APIDataTransferService
    
    public init (apiDataTransferService: APIDataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
}

public struct Module {

    private let diContainer: DIContainer
    
    public init(dependencies: ModuleDependencies) {
        self.diContainer = DIContainer(dependencies: dependencies)
    }
    
    public func startFriendsSearchFlow(in navigationController: UINavigationController) {
        let flow = diContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
