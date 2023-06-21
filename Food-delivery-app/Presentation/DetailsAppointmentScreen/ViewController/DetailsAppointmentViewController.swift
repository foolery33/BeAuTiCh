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

			self.ui.configure(with: appointment)
		}
	}
    func setActionHandlers() {
        ui.onBackArrowButtonTapped = { [weak self] in
            self?.viewModel.goBackScreen()
        }
        ui.onClientAcceptedButtonTapped = { [weak self] in
            Task {
                if await self?.viewModel.changeAppointmentStatus(newStatus: .completed) ?? false {
                    self?.showAlert(title: R.string.detailsAppointmentScreen.status_change_success(), message: R.string.detailsAppointmentScreen.status_change_success_message())
                }
                else {
                    self?.showAlert(title: R.string.errors.appointment_status_change_error(), message: self?.viewModel.error ?? "")
                }
            }
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
    }
}
