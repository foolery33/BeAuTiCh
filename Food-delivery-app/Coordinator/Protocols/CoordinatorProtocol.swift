//
//  CoordinatorProtocol.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import UIKit

protocol CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol? { get set }
    var children: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}

extension CoordinatorProtocol {
    mutating func childDidFinish(_ coordinator: CoordinatorProtocol) {
        for (index, child) in children.enumerated() {
            if child as AnyObject === coordinator as AnyObject {
                children.remove(at: index)
                break
            }
        }
    }
}
