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
	private var viewModel: SettingsViewModel

	private var alertController = UIAlertController()

	private lazy var dateTimeAppointmentPicker: UIDatePicker = {
		let view = UIDatePicker()
		view.datePickerMode = .countDownTimer
		view.preferredDatePickerStyle = .wheels
		return view
	}()
    
    //MARK: - Internal properties
    
    weak var delegate: SheetViewControllerDelegate?
	var convertDateToDdMmYyyy: ((Date) -> (String))?
    
    
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

	func showAlertService(service: ServiceModel?) {
		if service != nil {
			alertController = UIAlertController(title: R.string.yourServicesViewScreen.edit_service(), message: nil, preferredStyle: .alert)
		} else {
			alertController = UIAlertController(title: R.string.yourServicesViewScreen.create_service(), message: nil, preferredStyle: .alert)
		}

		alertController.addTextField { nameTextField in
			nameTextField.placeholder = R.string.yourServicesViewScreen.input_name_service()
			nameTextField.text = service?.name
		}

		alertController.addTextField { priceTextField in
			priceTextField.placeholder = R.string.yourServicesViewScreen.input_price_service()
			if let price = service?.price {
				priceTextField.text = "\(price)"
			}
		}

		alertController.addTextField { durationTextField in
			durationTextField.placeholder = R.string.yourServicesViewScreen.choose_duration_service()

			let toolbar = UIToolbar()
			toolbar.sizeToFit()

			let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onFromDateDoneButtonPressed))
			doneButton.tintColor = R.color.vinous()
 			toolbar.setItems([doneButton], animated: true)

			durationTextField.inputAccessoryView = toolbar
			durationTextField.inputView = self.dateTimeAppointmentPicker
			durationTextField.text = service?.duration
		}

		
		let actionCancel = UIAlertAction(title: R.string.yourServicesViewScreen.cancel(), style: .cancel)
		let actionSave = UIAlertAction(title: R.string.yourServicesViewScreen.save(), style: .default) { [ weak self ] _ in

			if let priceText = self?.alertController.textFields?[1].text, let price = Double(priceText) {
				if service == nil {
					self?.createService(model: CreateService(
						name: self?.alertController.textFields?[0].text ?? String(),
						price: price,
						duration: self?.alertController.textFields?[2].text ?? String())
					)

				} else {
					self?.editService(serviceId: service!.id, model: EditService(
						name: self?.alertController.textFields?[0].text ?? String(),
						price: price,
					duration: self?.alertController.textFields?[2].text ?? String())
					)
				}
			} else {
				self?.showAlert(title: "Поле с ценником не заполнено или неправильного формата", message: nil)
			}
		}

		alertController.addAction(actionSave)
		alertController.addAction(actionCancel)

		alertController.view.tintColor = R.color.vinous()

		self.present(alertController, animated: true)
	}

	func showAlertChooseAction(serviceId: UUID) {
		let alertController = UIAlertController(title: R.string.yourServicesViewScreen.choose_action(), message: nil, preferredStyle: .alert)

		let actionCancel = UIAlertAction(title: R.string.yourServicesViewScreen.cancel(), style: .cancel)
		let actionEdit = UIAlertAction(title: R.string.yourServicesViewScreen.edit(), style: .default) { [ weak self ] _ in

			self?.getService(serviceId: serviceId)
		}
		let actionDelete = UIAlertAction(title: R.string.yourServicesViewScreen.delete(), style: .default) { [ weak self ] _ in

			self?.deleteService(serviceId: serviceId)
		}

		alertController.addAction(actionEdit)
		alertController.addAction(actionDelete)
		alertController.addAction(actionCancel)

		alertController.view.tintColor = R.color.vinous()

		self.present(alertController, animated: true)
	}

	func showErrorMessages(errorMessages: [String]) {
		var errors = String()

		errorMessages.forEach { message in
			errors.append("\n" + message + "\n")
		}

		let alertController = UIAlertController(title: "Внимание!", message: errors, preferredStyle: .alert)
		let action = UIAlertAction(title: "Закрыть", style: .cancel)

		alertController.addAction(action)
		alertController.view.tintColor = R.color.vinous()

		self.present(alertController, animated: true, completion: nil)
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

			self.showAlertService(service: nil)
        }

		ui.onServiceTagTapped = { [ weak self ] shortModel in
			guard let self = self else { return }

            self.showAlertChooseAction(serviceId: shortModel.id)
		}

		ui.subscribeButtonHandler = { [ weak self ] in
			guard let self = self else { return }

			self.subscribe()
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

		viewModel.errorMessages.subscribe { [ weak self ] errorMessages in
			guard let self = self else { return }

			DispatchQueue.main.async {
				self.showErrorMessages(errorMessages: errorMessages)
			}
		}
	}
}

private extension YourServicesViewController {
	func checkingForSubscriptionAvailability() {
		self.ui.setupActivityIndicator()
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

			self.ui.stopActivityIndicator()
		}
	}

	func createService(model: CreateService) {
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			if await viewModel.createNewService(model: model) {
				checkingForSubscriptionAvailability()
			}

			self.ui.stopActivityIndicator()
		}
	}

	func deleteService(serviceId: UUID) {
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			if await viewModel.deleteDervice(serviceId: serviceId) {
				checkingForSubscriptionAvailability()
			}

			self.ui.stopActivityIndicator()
		}
	}

	func subscribe() {
		self.ui.setupActivityIndicator()
		Task {
			if await viewModel.subscribe() {
				self.dismiss()
			}

			self.ui.stopActivityIndicator()
		}
	}

	func getService(serviceId: UUID) {
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			let service = await viewModel.getService(serviceId: serviceId)
			DispatchQueue.main.async {
				self.showAlertService(service: service)
			}

			self.ui.stopActivityIndicator()
		}
	}

	func editService(serviceId: UUID, model: EditService) {
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			if await viewModel.editService(serviceId: serviceId, model: model) {
				checkingForSubscriptionAvailability()
			}

			self.ui.stopActivityIndicator()
		}
	}

	@objc func onFromDateDoneButtonPressed() {
		alertController.textFields?[2].text = viewModel.convertTimeToHhMmSs(dateTimeAppointmentPicker.date)
		({ _ in })("\(dateTimeAppointmentPicker.date)")

		view.endEditing(true)
	}
}
