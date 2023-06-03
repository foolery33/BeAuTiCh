//
//  SceneDelegate.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import UIKit
import NeedleFoundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        registerProviderFactories()
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        appCoordinator = CoordinatorFactory().createAppCoordinator(navigationController: navigationController)
        window = UIWindow(windowScene: windowScene)

        appCoordinator?.start()
        
        window?.rootViewController = appCoordinator?.navigationController
        window?.makeKeyAndVisible()
    }
    

}

