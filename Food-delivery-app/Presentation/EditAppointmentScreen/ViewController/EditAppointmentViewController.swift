//
//  EditAppointmentViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import UIKit

class EditAppointmentViewController: UIViewController {

	private let ui: EditAppointmentView
	private let viewModel: EditAppointmentViewModel

	init(viewModel: EditAppointmentViewModel) {
		self.viewModel = viewModel
		ui = EditAppointmentView()

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
		setHandler()
    }
}

private extension EditAppointmentViewController {
	func bindListener() {
		viewModel.appointment.subscribe { [ weak self ] appointment in
			guard let self = self else { return }

			self.ui.setTextField(model: appointment)
		}
	}

	func setHandler() {
		ui.convertDateToDdMmYyyyHhMm = { [weak self] date in
			return self?.viewModel.convertDateToDdMmYyyy(date) ?? ""
		}

		ui.arrowBackButtonHandler = { [weak self] in
			guard let self = self else { return }

			self.viewModel.goBack()
		}

		ui.goToShooseServicesButtonHandler = { [weak self] in
			guard let self = self else { return }

			self.viewModel.goToServiceSelectionScreen()
		}

		ui.saveButtonHandler = { [weak self] in
			guard let self = self else { return }

			self.viewModel.saveEditData()
		}
	}
}
