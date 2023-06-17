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
        
        let mainNavigationController = getMainUINavigationController()
        let searchNavigationController = getSearchUINavigationController()
        let profileNavigationController = getProfileUINavigationController()
        let settingsNavigationController = getSettingsUINavigationController()
        
        let mainCoordinator = getMainCoordinator(navController: mainNavigationController)
        let searchCoordinator = getSearchCoordinator(navController: searchNavigationController)
        let settingsCoordinator = getSettingsCoordinator(navController: settingsNavigationController)
        
        viewController.viewControllers = [mainNavigationController, searchNavigationController, settingsNavigationController, profileNavigationController]
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        parentCoordinator?.children.append(mainCoordinator)
        parentCoordinator?.children.append(searchCoordinator)
//        parentCoordinator?.children.append(profileCoordinator)
        parentCoordinator?.children.append(settingsCoordinator)
        
        mainCoordinator.start()
        searchCoordinator.start()
//        profileCoordinator.start()
        settingsCoordinator.start()
        
    }
    
    
    // MARK: - Getting screen's navigation controller
    
    func getMainUINavigationController() -> UINavigationController {
        let mainItem = UITabBarItem()
        mainItem.image = R.image.unselectedHouse()
        mainItem.selectedImage = R.image.selectedHouse()
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.setNavigationBarHidden(true, animated: false)
        mainNavigationController.tabBarItem = mainItem
        
        return mainNavigationController
    }
    
    func getSearchUINavigationController() -> UINavigationController {
        let searchItem = UITabBarItem()
        searchItem.image = R.image.unselectedSearch()
        searchItem.selectedImage = R.image.selectedSearch()
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.setNavigationBarHidden(true, animated: false)
        searchNavigationController.tabBarItem = searchItem
        
        return searchNavigationController
    }
    
    func getProfileUINavigationController() -> UINavigationController  {
        let profileItem = UITabBarItem()
        profileItem.image = R.image.unselectedPerson()
        profileItem.selectedImage = R.image.selectedPerson()
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.setNavigationBarHidden(true, animated: false)
        profileNavigationController.tabBarItem = profileItem
        
        return profileNavigationController
    }
    
    func getSettingsUINavigationController() -> UINavigationController  {
        let settingsItem = UITabBarItem()
        settingsItem.image = R.image.unselectedSettings()
        settingsItem.selectedImage = R.image.selectedSettings()
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.setNavigationBarHidden(true, animated: false)
        settingsNavigationController.tabBarItem = settingsItem
        
        return settingsNavigationController
    }
    
    
    // MARK: - Getting screen's coordinator
    
    func getMainCoordinator(navController: UINavigationController) -> MainCoordinator {
        let mainCoordinator = MainCoordinator(navigationController: navController)
        mainCoordinator.parentCoordinator = parentCoordinator
        
        return mainCoordinator
    }
    
    func getSearchCoordinator(navController: UINavigationController) -> SearchCoordinator {
        let searchCoordinator = SearchCoordinator(navigationController: navController)
        searchCoordinator.parentCoordinator = parentCoordinator

        return searchCoordinator
    }
//
//    func getProfileCoordinator(navController: UINavigationController) -> ProfileCoordinator {
//        let profileCoordinator = ProfileCoordinator(navigationController: navController)
//        profileCoordinator.parentCoordinator = parentCoordinator
//
//        return profileCoordinator
//    }
    
    func getSettingsCoordinator(navController: UINavigationController) -> SettingsCoordinator {
        let settingsCoordinator = SettingsCoordinator(navigationController: navController)
        settingsCoordinator.parentCoordinator = parentCoordinator
        
        return settingsCoordinator
    }
}
