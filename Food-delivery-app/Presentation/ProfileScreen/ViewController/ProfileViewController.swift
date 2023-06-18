//
//  ProfileViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import UIKit

class ProfileViewController: UIViewController {

	// MARK: - Private properties

	private let ui: ProfileView
	private let viewModel: ProfileViewModel

	// MARK: - Init

	init(viewModel: ProfileViewModel) {
		self.ui = ProfileView()
		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Life cycle

	override func loadView() {
		self.view = ui
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		setHandlers()
		setBindListener()
		fetchDataProfile()
    }


	// MARK: - Private methods

	private func showAlertChangeData() {
		let alertController = UIAlertController(title: R.string.profileScreen.title_alert_input_data(), message: nil, preferredStyle: .alert)

		let profile = ChangeDataProfileModel(fullName: ui.getFullname(), phoneNumber: ui.getPhone())

		alertController.addTextField { fullnameTextField in
			fullnameTextField.placeholder = R.string.profileScreen.input_name()
			fullnameTextField.text = profile.fullName
		}

		alertController.addTextField { phoneTextField in
			phoneTextField.placeholder = R.string.profileScreen.input_phone()
			phoneTextField.text = profile.phoneNumber
		}

		let actionSave = UIAlertAction(title: R.string.profileScreen.save(), style: .default) { [ weak self ] action in

			self?.changeDataProfile(with: ChangeDataProfileModel(fullName: alertController.textFields?[0].text ?? String(), phoneNumber: alertController.textFields?[1].text))
		}
		let actionCancel = UIAlertAction(title: R.string.profileScreen.cancel(), style: .cancel)

		alertController.addAction(actionSave)
		alertController.addAction(actionCancel)

		alertController.view.tintColor = R.color.accentColor()

		self.present(alertController, animated: true)
	}

	private func showError(_ error: String) {
		let alertController = UIAlertController(title: "Внимание!", message: error, preferredStyle: .alert)
		let action = UIAlertAction(title: "Закрыть", style: .cancel)

		alertController.addAction(action)

		alertController.view.tintColor = R.color.accentColor()

		self.present(alertController, animated: true)
	}
}

private extension ProfileViewController {
	func setHandlers() {
		ui.signOutButtonHandler = { [ weak self ] in
			guard let self = self else { return }
		}

		ui.changeAvatarButtonHandler = { [ weak self ] in
			guard let self = self else { return }
		}

		ui.deleteAvatarButtonHandler = { [ weak self ] in
			guard let self = self else { return }
		}

		ui.changeDataProfileButtonHandler = { [ weak self ] in
			guard let self = self else { return }

			self.showAlertChangeData()
		}

		ui.changePasswordButtonHandler = { [ weak self ] in
			guard let self = self else { return }
		}
	}

	func setBindListener() {
		viewModel.profile.subscribe { [ weak self ] profile in
			guard let self = self else { return }

			DispatchQueue.main.async {
				self.ui.setDataProfile(profile: profile)
			}
		}

		viewModel.errorMessage.subscribe { errorMessage in
			print(errorMessage)
			//showAlert(title: R.string.errors.appointments_loading_error(), message: viewModel.error)
		}
	}
}

private extension ProfileViewController {
	func fetchDataProfile() {
		Task {
			await viewModel.fetchDataProfile()
		}
	}

	func changeDataProfile(with model: ChangeDataProfileModel) {
		Task {
			if await viewModel.changeDataProfile(with: model) {
				fetchDataProfile()
			}
		}
	}
}
