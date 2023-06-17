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
    }

}
