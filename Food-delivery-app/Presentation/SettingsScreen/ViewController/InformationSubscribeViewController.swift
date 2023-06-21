//
//  InformationSubscribeViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

class InformationSubscribeViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let ui: InformationSubscribeView
    
    
    //MARK: - Internal properties
    
    weak var delegate: SheetViewControllerDelegate?
    var viewModel: SettingsViewModel
    
    
    //MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        ui = InformationSubscribeView()
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
		bindListener()
    }
    
    
    //MARK: - Private methods
    
    private func dismiss() {
        delegate?.didDismissSheetViewController()
        dismiss(animated: true, completion: nil)
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
}

private extension InformationSubscribeViewController {
    func setHandlers() {
        ui.arrowBackButtonHandler = { [ weak self ] in
            guard let self = self else { return }
            
            self.dismiss()
        }
        
        ui.cancelSubscriptionButtonHandler = { [ weak self ] in
            guard let self = self else { return }

			self.cancelSubscribe()
        }

		ui.subscribeButtonHandler = { [ weak self ] in
			guard let self = self else { return }

			self.subscribe()
		}
    }

	func bindListener() {
		viewModel.subscribe.subscribe { [ weak self ] subscribe in
			guard let self = self else { return }

			print(subscribe)
			DispatchQueue.main.async {
				self.ui.setStartDateSubscribe(self.viewModel.convertDateToDdMmYyyy(subscribe.createDate))
			}
		}
	}
}

private extension InformationSubscribeViewController {
	func checkingForSubscriptionAvailability() {
		Task {
			if let check = await viewModel.isThereSubscription() {
				check ? ui.setupScreen() : ui.setupPlug()
			} else {
				DispatchQueue.main.async {
					if let errorMessage = self.viewModel.errorMessage.data {
						self.showAlertErrorMessage(title: "\(errorMessage)", message: nil)
					}
				}
			}
		}
	}

	func subscribe() {
		Task {
			if await viewModel.subscribe() {
				self.dismiss()
			}

		}
	}

	func cancelSubscribe() {
		Task {
			if await viewModel.cancelSubscribe() {
				self.dismiss()
			}
		}
	}
}
