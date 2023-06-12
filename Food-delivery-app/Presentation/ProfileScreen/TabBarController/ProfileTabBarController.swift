//
//  ProfileTabBarController.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

class ProfileTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateTabBarAttributes() {
        guard let viewControllers = viewControllers else { return }
        for viewController in viewControllers {
            if viewController == selectedViewController {
                
            } else {
                
            }
        }
    }
    
    override var selectedIndex: Int {
        didSet {
            updateTabBarAttributes()
        }
    }
    
    override var selectedViewController: UIViewController? {
        didSet {
            updateTabBarAttributes()
        }
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.barTintColor = .white
        tabBar.tintColor = R.color.white()
        tabBar.unselectedItemTintColor = R.color.white()
        tabBar.isTranslucent = false
        tabBar.itemPositioning = .centered
        additionalSafeAreaInsets.bottom = 60
    }
}
