//
//  StartViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

final class StartViewModel {
    
    weak var coordinator: AuthCoordinator?
    
    func goToAuthScreen() {
        coordinator?.goToLoginScreen()
    }
    
}
