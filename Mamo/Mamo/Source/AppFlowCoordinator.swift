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

        // In App Flow we can check if user needs to login, if yes we would run login flow
//        let moviesSearchModule = appDIContainer.makeMoviesSearchModule()
//        moviesSearchModule.startMoviesSearchFlow(in: navigationController)
    }
}
