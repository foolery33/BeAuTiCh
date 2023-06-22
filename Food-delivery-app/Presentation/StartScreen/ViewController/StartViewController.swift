//
//  StartViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit

final class StartViewController: UIViewController {

    private let viewModel: StartViewModel
    private let ui: StartView
    
    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        ui = StartView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = ui
        handleTouchActions()
    }

}

private extension StartViewController {
    
    func handleTouchActions() {
        ui.onLoginButtonTapped = { [weak self] in
            self?.viewModel.goToAuthScreen()
        }
    }
    
}
