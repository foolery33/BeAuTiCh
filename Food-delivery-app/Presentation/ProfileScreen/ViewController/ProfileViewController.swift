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

	lazy var imagePicker: UIImagePickerController = {
		let vc = UIImagePickerController()
		vc.delegate = self
		vc.allowsEditing = true
		return vc
	}()
	@objc private func showImagePicker() {
		self.showAlertWithChoice()
	}

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
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

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

	private func showAlertChoosePhoto() {
		let alertController = UIAlertController(title: "Выберите источник фотографии", message: nil, preferredStyle: .alert)
		let actionChooseCamera = UIAlertAction(title: "Камера", style: .default) { _ in
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = .camera
			imagePicker.allowsEditing = true

			imagePicker.showsCameraControls = true

			self.present(imagePicker, animated: true, completion: nil)
		}
		let actionChooseGalery = UIAlertAction(title: "Галерея", style: .default) { _ in
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.allowsEditing = true

			self.present(imagePicker, animated: true, completion: nil)
		}
		let actionCancel = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)

		alertController.addAction(actionChooseGalery)
		alertController.addAction(actionChooseCamera)
		alertController.addAction(actionCancel)


		self.present(alertController, animated: true, completion: nil)
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

			self.logout()
		}

		ui.changeAvatarButtonHandler = { [ weak self ] in
			guard let self = self else { return }

			self.showAlertWithChoice()
		}

		ui.deleteAvatarButtonHandler = { [ weak self ] in
			guard let self = self else { return }

			self.deleteAvatar()
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
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			await viewModel.fetchDataProfile()
			self.ui.stopActivityIndicator()
		}
	}

	func changeDataProfile(with parameters: ChangeDataProfileModel) {
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			if await viewModel.changeDataProfile(with: parameters) {
				fetchDataProfile()
			}
			self.ui.stopActivityIndicator()
		}
	}

	func changePassword(parameters: ChangePassword) {
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			if await viewModel.changePassword(parameters: parameters) {
				self.showAlert(title: R.string.profileScreen.susscess_change_password(), message: nil)
			}
			self.ui.stopActivityIndicator()
		}
	}

	func getAvatar() {
		self.ui.setupActivityIndicator(withBackground: false)
		Task {
			ui.setAvatar(avatar: await viewModel.getAvatar())
			self.ui.stopActivityIndicator()
		}
	}

	func deleteAvatar() {
		self.ui.setupActivityIndicator()
		Task {
			if await viewModel.deleteAvatar() {
				showAlert(title: R.string.profileScreen.success_deleted_avatar(), message: nil)

				DispatchQueue.main.async {
					self.ui.setAvatar(avatar: R.image.defaultAvatar() ?? UIImage())
				}
			}
			self.ui.stopActivityIndicator()
		}
	}

	func logout() {
		self.ui.setupActivityIndicator()
		Task {
			if await viewModel.logout() {
				viewModel.goToAuthScreen()
			}
			self.ui.stopActivityIndicator()
		}
	}

	func setAvatar(imageData: Data, image: UIImage) {
		viewModel.setAvatar(imageData: imageData) { success in
			if success {
				self.ui.setAvatar(avatar: image)
			}
		}
	}
}

//- MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
			return
		}

		if let imageData = image.jpegData(compressionQuality: 0.3) {
			if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
				self.setAvatar(imageData: imageData, image: image)
			}
		}
		picker.dismiss(animated: true, completion: nil)
	}


	func showAlertWithChoice() {
		let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .alert)

		alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
			self.imagePicker.sourceType = .camera
			self.present(self.imagePicker, animated: true)
		}))

		alert.addAction(UIAlertAction(title: "Photo", style: .default, handler: { _ in
			self.imagePicker.sourceType = .photoLibrary
			self.present(self.imagePicker, animated: true)
		}))

		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		present(alert, animated: true)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
}
