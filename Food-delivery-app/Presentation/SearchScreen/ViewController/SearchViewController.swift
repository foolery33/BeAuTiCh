//
//  SearchViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel
    private let ui: SearchView
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        ui = SearchView()
        super.init(nibName: nil, bundle: nil)
        self.handleViewEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppointmentList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        getAppointmentList()
    }

}

extension SearchViewController {
    
    private func handleViewEvents() {
        
        ui.onTextFieldValueChange = { [weak self] text in
            self?.viewModel.clientName = text
        }
        ui.convertTime = { [weak self] dateTime in
            self?.viewModel.convertISOToReadableDateAndTime(dateTime) ?? ""
        }
        ui.getFilteredAppointmentList = { [weak self] appointmentList, filterString in
            self?.viewModel.getFilteredAppointmentList(from: appointmentList, with: filterString) ?? []
        }
        ui.onFilterButtonTapped = { [weak self] in
            self?.viewModel.goToFilterScreen()
        }
        
    }
    
    func getAppointmentList() {
        Task {
            if await viewModel.getAppointmentList() {
                print(viewModel.appointmentList)
                ui.appointmentList = viewModel.appointmentList
                ui.updateAppointmentsStackView(currentAppointments: viewModel.appointmentList)
            }
            else {
                showAlert(title: R.string.errors.appointments_loading_error(), message: viewModel.error)
            }
        }
    }
    
}
