//
//  AppDelegate.swift
//  Mamo
//
//  Created by Huy Nguyen on 31/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppAppearance.setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ViewController())

        window?.rootViewController = navigationController
//        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
//                                                appDIContainer: appDIContainer)
//        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}

