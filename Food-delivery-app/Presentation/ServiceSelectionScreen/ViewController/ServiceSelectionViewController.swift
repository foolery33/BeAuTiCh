//
//  ServiceSelectionViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import UIKit

class ServiceSelectionViewController: UIViewController {

    private let viewModel: ServiceSelectionViewModel
    private let ui: ServiceSelectionView
    
    init(viewModel: ServiceSelectionViewModel) {
        self.viewModel = viewModel
        ui = ServiceSelectionView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = ui
        getAllServices()
        setActionHandlers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onServiceSelectionSheetDismissed()
    }
    
}

private extension ServiceSelectionViewController {
    
    func setActionHandlers() {
        ui.arrowBackButtonHandler = { [weak self] in
            self?.dismiss(animated: true)
        }
        ui.onServiceTapped = { [weak self] shortModel in
            self?.viewModel.onServiceTagTapped(shortModel: shortModel)
        }
    }
    
    func getAllServices() {
		self.ui.setupActivityIndicator(withBackground: false)
        Task {
            if await viewModel.getAllServices() {
                ui.setSelectedServiceIds(viewModel.selectedServiceIds)
                ui.setServices(viewModel.servicesList)
            }
            else {
                showAlert(title: R.string.errors.services_loading_error(), message: viewModel.error)
            }
			self.ui.stopActivityIndicator()
        }
    }
}
