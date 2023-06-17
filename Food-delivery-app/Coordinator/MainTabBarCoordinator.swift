//
//  MainTabBarCoordinator.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 11.06.2023.
//

import UIKit

final class MainTabBarCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        initializeMainTabBar()
    }
    
    private func initializeMainTabBar() {
        let viewController = MainTabBarController()
//        viewController.view.backgroundColor = R.color.backgroundColor()
        
        // MARK: - MainScreen
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.setNavigationBarHidden(true, animated: false)
        let mainCoordinator = MainCoordinator(navigationController: mainNavigationController)
        mainCoordinator.parentCoordinator = parentCoordinator
        
        let mainItem = UITabBarItem()
        mainItem.image = R.image.unselectedHouse()
        mainItem.selectedImage = R.image.selectedHouse()
        mainNavigationController.tabBarItem = mainItem
        
        // MARK: - SearchScreen
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.setNavigationBarHidden(true, animated: false)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        searchCoordinator.parentCoordinator = parentCoordinator

        let searchItem = UITabBarItem()
        searchItem.image = R.image.unselectedSearch()
        searchItem.selectedImage = R.image.selectedSearch()
        searchNavigationController.tabBarItem = searchItem
        
        // MARK: - ProfileScreen
        
//        let profileNavigationController = UINavigationController()
//        profileNavigationController.setNavigationBarHidden(true, animated: false)
//        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
//        profileCoordinator.parentCoordinator = parentCoordinator
//
//        let profileItem = UITabBarItem()
//        profileItem.image = R.image.unselectedPerson()
//        profileItem.selectedImage = R.image.selectedPerson()
//        profileNavigationController.tabBarItem = profileItem

        // MARK: - SettingsScreen
        
//        let settingsNavigationController = UINavigationController()
//        let settingsCoordinator = SettingsCoordinator(navigationController: settingsNavigationController)
//        settingsCoordinator.parentCoordinator = parentCoordinator
//
//        let settingsItem = UITabBarItem()
//        settingsItem.image = R.image.unselectedSettings()
//        settingsItem.selectedImage = R.image.selectedSettings()
//        settingsNavigationController.tabBarItem = settingsItem
        
        viewController.viewControllers = [mainNavigationController, searchNavigationController]
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        parentCoordinator?.children.append(mainCoordinator)
        parentCoordinator?.children.append(searchCoordinator)
//        parentCoordinator?.children.append(collectionsCoordinator)
//        parentCoordinator?.children.append(profileCoordinator)
        
        mainCoordinator.start()
        searchCoordinator.start()
//        collectionsCoordinator.start()
//        profileCoordinator.start()
        
    }
    
}
