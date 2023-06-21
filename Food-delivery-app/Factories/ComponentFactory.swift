//
//  ComponentFactory.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 31.05.2023.
//

import Foundation

final class ComponentFactory {
    
    private let mainComponent = MainComponent()
    
    func getStartComponent() -> StartComponent {
        return mainComponent.startComponent
    }
    
    func getLoginComponent() -> LoginComponent {
        return mainComponent.loginComponent
    }
    
    func getRegisterComponent() -> RegisterComponent {
        return mainComponent.registerComponent
    }
    
    func getMainScreenComponent() -> MainScreenComponent {
        return mainComponent.mainScreenComponent
    }
    
    func getSettingsComponent() -> SettingsComponent {
        return mainComponent.settingsComponent
    }
    
    func getInformationSubscribeComponent() -> InformationSubscribeComponent {
        return mainComponent.informationSubscribeComponent
    }
    
    func getYourServicesComponent() -> YourServicesComponent {
        return mainComponent.yourServicesComponent
    }

    func getSearchComponent() -> SearchComponent {
        return mainComponent.searchComponent
    }

	func getFilterComponent() -> FilterComponent {
		return mainComponent.filterComponent
	}
    
    func getServiceSelectionComponent() -> ServiceSelectionComponent {
        return mainComponent.serviceSelectionComponent
    }

	func getProfileComponent() -> ProfileComponent {
		return mainComponent.profileComponent
	}

	func getDetailsAppointmentComponent() -> DetailsAppointmentComponent {
		return mainComponent.detailsAppointment
	}

	func getAddAppointmentComponent() -> AddAppointmentComponent {
		return mainComponent.addAppointmentComponent
	}

	func getEditAppointmentComponent() -> EditAppointmentComponent {
		return mainComponent.editAppointmentComponent
	}
}
