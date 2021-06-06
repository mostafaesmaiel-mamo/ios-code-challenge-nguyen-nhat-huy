//
//  Module.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation
import Networking

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
    
    public func startFriendListFlow(in navigationController: UINavigationController) {
        let flow = diContainer.makeFriendListFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
