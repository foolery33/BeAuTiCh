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
	}
}

private extension DetailsAppointmentViewController {
	func bindListener() {
		viewModel.appointment.subscribe { [ weak self ] appointment in
			guard let self = self else { return }

			self.ui.configure(with: appointment)
		}
	}
}
