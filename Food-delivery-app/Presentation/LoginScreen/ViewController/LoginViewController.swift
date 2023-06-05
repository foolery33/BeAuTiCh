//
//  ViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel
    private let ui: LoginView
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.ui = LoginView()
        
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
        
        setupKeyboardDismiss()
        setHandlers()
    }
}

private extension LoginViewController {
    func setHandlers() {
        ui.loginButtonHandler = { [ weak self ] in
            guard let self = self else { return }
        }
        
        ui.goToRegisterScreenButtonHandler = { [ weak self ] in
            guard let self = self else { return }
        }
    }
}
