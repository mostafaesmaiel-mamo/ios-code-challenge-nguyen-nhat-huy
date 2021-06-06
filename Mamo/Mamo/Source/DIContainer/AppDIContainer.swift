//
//  AppDIContainer.swift
//  Mamo
//
//  Created by Huy Nguyen on 31/05/2021.
//

import Foundation
import Networking
import FriendList

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfigurations()
    
    // MARK: - Network
    lazy var apiDataTransferService: APIDataTransferService = {
        let config = APIDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!, headers: [:], queryParameters: [:])
        let apiDataNetwork  = NetworkServiceDefault(config: config)
        return APIDataTransferServiceDefault(with: apiDataNetwork)
    }()
    
    // MARK: - Feature Modules
    func makeFriendListModule() -> FriendList.Module {
        let dependencies = FriendList.ModuleDependencies(apiDataTransferService: apiDataTransferService)
        return FriendList.Module(dependencies: dependencies)
    }
}
