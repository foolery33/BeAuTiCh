//
//  SettingsViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

final class SettingsViewModel {
    weak var coordinator: SettingsCoordinator?
    
    func goToInformationSubcribeScreen(delegate: SheetViewControllerDelegate) {
        coordinator?.goToInformationSubcribeScreen(delegate: delegate)
    }
    
    func goToServicesScreen(delegate: SheetViewControllerDelegate) {
        coordinator?.goToServicesScreen(delegate: delegate)
    }

	func isThereSubscription() -> Bool {
		return true
	}
}
