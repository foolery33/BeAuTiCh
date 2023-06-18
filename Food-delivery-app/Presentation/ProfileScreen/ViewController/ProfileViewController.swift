//
//  ProfileViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import UIKit

class ProfileViewController: UIViewController {

	private let ui: ProfileView
	private let viewModel: ProfileViewModel

	init(viewModel: ProfileViewModel) {
		self.ui = ProfileView()
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

		setHandlers()
		setBindListener()
		fetchDataProfile()
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

	func fetchDataProfile() {
		Task {
			await viewModel.fetchDataProfile()
		}
	}
}
