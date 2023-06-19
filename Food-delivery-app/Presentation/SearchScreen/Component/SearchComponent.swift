//
//  SearchComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit
import NeedleFoundation

protocol SearchComponentDependency: Dependency {
    var appointmentRepository: AppointmentRepository { get }
    var convertISOToReadableDateAndTimeUseCase: ConvertISOToReadableDateAndTimeUseCase { get }
    var getFilteredAppointmentListUseCase: GetFilteredAppointmentListUseCase { get }
}

final class SearchComponent: Component<SearchComponentDependency> {
    var searchViewModel: SearchViewModel {
        shared {
            SearchViewModel(
                appointmentRepository: dependency.appointmentRepository,
                convertISOToReadableDateAndTimeUseCase: dependency.convertISOToReadableDateAndTimeUseCase, getFilteredAppointmentListUseCase: dependency.getFilteredAppointmentListUseCase
            )
        }
    }
    
    var searchViewController: SearchViewController {
        return SearchViewController(viewModel: searchViewModel)
    }
}
