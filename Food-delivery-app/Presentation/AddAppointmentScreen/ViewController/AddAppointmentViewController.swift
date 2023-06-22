//
//  AddAppointmentViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import UIKit

class AddAppointmentViewController: UIViewController {

	private let ui: AddAppointmentView
	private let viewModel: AddAppointmentViewModel

	init(viewModel: AddAppointmentViewModel) {
		self.ui = AddAppointmentView()
		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = ui
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setHandler()
	}
}

private extension AddAppointmentViewController {
	func setHandler() {
		ui.convertDateToDdMmYyyy = { [weak self] date in
			return self?.viewModel.convertDateToDdMmYyyy(date) ?? ""
		}

		ui.arrowBackButtonHandler = { [weak self] in
			guard let self = self else { return }

			self.viewModel.goBack()
		}

		ui.goToChooseServicesButtonHandler = { [weak self] in
			guard let self = self else { return }

			self.viewModel.goToServiceSelectionScreen()
		}

		ui.saveButtonHandler = { [weak self] in
			guard let self = self else { return }
            self.ui.setupActivityIndicator()
            Task {
                if await self.viewModel.createAppointment() {
                    self.showAlert(title: R.string.addAppointmentScreen.success(), message: R.string.addAppointmentScreen.create_appointment_success())
                }
                else {
                    self.showAlert(title: R.string.errors.appointment_creation_error(), message: self.viewModel.error)
                }
                self.ui.stopActivityIndicator()
            }
		}
        
        ui.onNameTextFieldValueChanged = { [weak self] text in
            self?.viewModel.clientName = text
        }
        
        ui.onDateTextFieldValueChanged = { [weak self] text in
			if let date = text {
				self?.viewModel.appointmentDate = date
			}
        }
        
        ui.onPhoneNumberTextFieldValueChanged = { [weak self] text in
            self?.viewModel.phoneNumber = text
        }
	}
}
