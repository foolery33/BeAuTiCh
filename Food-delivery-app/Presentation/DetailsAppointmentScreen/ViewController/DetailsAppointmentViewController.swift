//
//  DetailsAppointmentViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import UIKit

class DetailsAppointmentViewController: UIViewController {

	private let ui: DetailsAppointmentView
	private let viewModel: DetailsAppointmentViewModel

	init(viewModel: DetailsAppointmentViewModel) {
		self.viewModel = viewModel
		ui = DetailsAppointmentView()

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

		bindListener()
        setActionHandlers()
	}
}

private extension DetailsAppointmentViewController {
	func bindListener() {
		viewModel.appointment.subscribe { [ weak self ] appointment in
			guard let self = self else { return }

            self.configureUI(with: appointment)
		}
	}
    func setActionHandlers() {
        ui.onBackArrowButtonTapped = { [weak self] in
            self?.viewModel.goBackScreen()
        }

        ui.onClientAcceptedButtonTapped = { [weak self] in
			self?.setAcceptedStatusAppointment()
        }

        ui.onCancelAppointmentButtonTapped = { [weak self] in
            Task {
                if await self?.viewModel.changeAppointmentStatus(newStatus: .cancelled) ?? false {
                    self?.showAlert(title: R.string.detailsAppointmentScreen.status_change_success(), message: R.string.detailsAppointmentScreen.status_change_success_message())
                }
                else {
                    self?.showAlert(title: R.string.errors.appointment_status_change_error(), message: self?.viewModel.error ?? "")
                }
            }
        }

		ui.onDeleteButtonTapped = { [weak self] in
			self?.deleteAppointment()
		}

        ui.onChangeDataButtonTapped = { [weak self] in
            self?.viewModel.goToEditAppointmentScreen()
        }
    }
}

private extension DetailsAppointmentViewController {
	func setCancelStatusAppointment() {
		self.ui.setupActivityIndicator()
		Task {
			if await viewModel.changeAppointmentStatus(newStatus: .cancelled){
				showAlert(title: R.string.detailsAppointmentScreen.status_change_success(), message: R.string.detailsAppointmentScreen.status_change_success_message())
			}
			else {
				showAlert(title: R.string.errors.appointment_status_change_error(), message: viewModel.error)
			}

			self.ui.stopActivityIndicator()
		}
	}

	func setAcceptedStatusAppointment() {
		self.ui.setupActivityIndicator()
		Task {
			if await viewModel.changeAppointmentStatus(newStatus: .completed) {
				showAlert(title: R.string.detailsAppointmentScreen.status_change_success(), message: R.string.detailsAppointmentScreen.status_change_success_message())
			}
			else {
				showAlert(title: R.string.errors.appointment_status_change_error(), message: viewModel.error)
			}

			self.ui.stopActivityIndicator()
		}
	}

	func deleteAppointment() {
		self.ui.setupActivityIndicator()
		Task {
			if await viewModel.deleteAppointment() {
				self.viewModel.goBackScreen()
			}
			self.ui.stopActivityIndicator()
		}
	}
}

extension DetailsAppointmentViewController {
    
    func configureUI(with appointment: AppointmentModel) {
        self.ui.configure(with: appointment)
    }
    
}
