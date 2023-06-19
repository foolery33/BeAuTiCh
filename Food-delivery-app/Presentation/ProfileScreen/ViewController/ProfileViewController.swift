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
		getAvatar()
    }


	// MARK: - Private methods

	private func showAlertChangeData() {
		let alertController = UIAlertController(title: R.string.profileScreen.title_alert_input_data(),
												message: nil,
												preferredStyle: .alert)
		let profile = ChangeDataProfileModel(fullName: ui.getFullname(), phoneNumber: ui.getPhone())

		alertController.addTextField { fullnameTextField in
			fullnameTextField.placeholder = R.string.profileScreen.input_name()
			fullnameTextField.text = profile.fullName
		}

		alertController.addTextField { phoneTextField in
			phoneTextField.placeholder = R.string.profileScreen.input_phone()
			phoneTextField.text = profile.phoneNumber
		}

		let actionCancel = UIAlertAction(title: R.string.profileScreen.cancel(), style: .cancel)
		let actionSave = UIAlertAction(title: R.string.profileScreen.save(), style: .default) { [ weak self ] action in

			self?.changeDataProfile(with: ChangeDataProfileModel(fullName: alertController.textFields?[0].text ?? String(),
																 phoneNumber: alertController.textFields?[1].text))
		}

		alertController.addAction(actionSave)
		alertController.addAction(actionCancel)

		alertController.view.tintColor = R.color.accentColor()

		self.present(alertController, animated: true)
	}

	private func showAlertChangePassword() {
		let alertController = UIAlertController(title: R.string.profileScreen.title_alert_change_password(),
												message: R.string.profileScreen.message_alert_change_password(),
												preferredStyle: .alert)

		alertController.addTextField { oldPasswordTextField in
			oldPasswordTextField.placeholder = R.string.profileScreen.input_old_password()
			oldPasswordTextField.isSecureTextEntry = true
		}

		alertController.addTextField { newPasswordTextField in
			newPasswordTextField.placeholder = R.string.profileScreen.input_new_password()
			newPasswordTextField.isSecureTextEntry = true
		}

		let actionCancel = UIAlertAction(title: R.string.profileScreen.cancel(), style: .cancel)
		let actionSave = UIAlertAction(title: R.string.profileScreen.save(), style: .default) { [ weak self ] action in

			self?.changePassword(parameters: ChangePassword(
				oldPassword: alertController.textFields?[0].text ?? String(),
				newPassword: alertController.textFields?[1].text ?? String()))
		}

		alertController.addAction(actionSave)
		alertController.addAction(actionCancel)

		alertController.view.tintColor = R.color.vinous()

		self.present(alertController, animated: true)
	}

	private func showError(_ error: String) {
		let alertController = UIAlertController(title: "Внимание!", message: error, preferredStyle: .alert)
		let action = UIAlertAction(title: "Закрыть", style: .cancel)

		alertController.addAction(action)

		alertController.view.tintColor = R.color.vinous()

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

			self.showAlertChangePassword()
		}
	}

	func setBindListener() {
		viewModel.profile.subscribe { [ weak self ] profile in
			guard let self = self else { return }

			DispatchQueue.main.async {
				self.ui.setDataProfile(profile: profile)
			}
		}

		viewModel.errorMessage.subscribe { [ weak self ] errorMessage in
			guard let self = self else { return }

			DispatchQueue.main.async {
				self.showAlert(title: R.string.errors.password_changed_error(),
							   message: errorMessage)
			}
		}
	}
}

private extension ProfileViewController {
	func fetchDataProfile() {
		Task {
			await viewModel.fetchDataProfile()
		}
	}

	func changeDataProfile(with parameters: ChangeDataProfileModel) {
		Task {
			if await viewModel.changeDataProfile(with: parameters) {
				fetchDataProfile()
			}
		}
	}

	func changePassword(parameters: ChangePassword) {
		Task {
			if await viewModel.changePassword(parameters: parameters) {
				self.showAlert(title: R.string.profileScreen.susscess_change_password(), message: nil)
			}
		}
	}

	func getAvatar() {
		Task {
			await viewModel.getAvatar()
		}
	}
}
