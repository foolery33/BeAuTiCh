//
//  YourServicesViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

class YourServicesViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let ui: YourServicesView
    
    
    //MARK: - Internal properties
    
    weak var delegate: SheetViewControllerDelegate?
    var viewModel: SettingsViewModel
    
    
    //MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        ui = YourServicesView()
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle
    
    override func loadView() {
		checkingForSubscriptionAvailability()
        self.view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        setHandlers()
//        ui.setServices([
//            ServiceModel(id: UUID(), name: "Blablabla", price: 12, duration: ""),
//            ServiceModel(id: UUID(), name: "bla", price: 12, duration: ""),
//            ServiceModel(id: UUID(), name: "jsdfsdfsdf", price: 12, duration: ""),
//            ServiceModel(id: UUID(), name: "Blablabla", price: 12, duration: ""),
//            ServiceModel(id: UUID(), name: "bla", price: 12, duration: ""),
//            ServiceModel(id: UUID(), name: "Blablabla", price: 12, duration: ""),
//            ServiceModel(id: UUID(), name: "bla", price: 12, duration: ""),
//        ])
		bindListener()
    }

	//MARK: - Internal methods
	func showAlertErrorMessage(title: String, message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: R.string.errors.ok(), style: .default){ [ weak self ] _ in

			self?.dismiss()
		})

		alert.view.tintColor = R.color.vinous()

		present(alert, animated: true)
	}
    
    //MARK: - Private methods
    private func dismiss() {
        delegate?.didDismissSheetViewController()
        dismiss(animated: true, completion: nil)
    }
}

private extension YourServicesViewController {
    func setHandlers() {
        ui.arrowBackButtonHandler = { [ weak self ] in
            guard let self = self else { return }
            
            self.dismiss()
        }
        
        ui.plusServiceButtonHandler = { [ weak self ] in
            guard let self = self else { return }
            
        }
    }

	func bindListener() {
		viewModel.customServices.subscribe { [ weak self ] services in
			guard let self = self else { return }

			if services.isEmpty {
				DispatchQueue.main.async {
					self.ui.setupPlugEmptyServices()
				}

			} else {
				DispatchQueue.main.async {
					self.ui.setupScreen()
					self.ui.setServices(services)
				}
			}
		}
	}
}

private extension YourServicesViewController {
	func checkingForSubscriptionAvailability() {
		Task {
			if let check = await viewModel.isThereSubscription() {
				if check {
					await viewModel.fetchCustomServices()

				} else {
					ui.setupPlugSubscribe()
				}
			} else {
				DispatchQueue.main.async {
					if let errorMessage = self.viewModel.errorMessage.data {
						self.showAlertErrorMessage(title: "\(errorMessage)", message: nil)
					}
				}
			}
		}
	}
}
