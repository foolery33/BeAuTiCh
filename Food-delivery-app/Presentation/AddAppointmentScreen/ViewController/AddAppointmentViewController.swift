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
			
		}

		ui.goToShooseServicesButtonHandler = { [weak self] in
			guard let self = self else { return }
		}

		ui.saveButtonHandler = { [weak self] in
			guard let self = self else { return }
		}
	}
}
