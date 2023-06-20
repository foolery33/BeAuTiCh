//
//  RegisterViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 03.06.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //- MARK: Private properties
    
    private let viewModel: RegisterViewModel
    private let ui: RegisterView
    
    
    //- MARK: Init
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        self.ui = RegisterView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //- MARK: Life cycle

    override func loadView() {
        self.view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardDismiss()
        setHandlers()
    }
}

private extension RegisterViewController {
    func setHandlers() {
        ui.registerButtonHandler = { [weak self] in
            self?.ui.setupActivityIndicator()
            Task {
                if await self?.viewModel.register() ?? false {
                    self?.viewModel.goToMainScreen()
                }
                else {
                    self?.showAlert(title: R.string.errors.register_error(), message: self?.viewModel.error ?? "")
                }
                self?.ui.stopActivityIndicator()
            }
        }
        ui.goToAuthButtonHandler = { [weak self] in
            self?.viewModel.goBackToLoginScreen()
        }
        
        ui.onLastNameTextFieldValueChanged = { [weak self] text in
            self?.viewModel.lastName = text
        }
        ui.onFirstNameTextFieldValueChanged = { [weak self] text in
            self?.viewModel.firstName = text
        }
        ui.onPatronymicTextFieldValueChanged = { [weak self] text in
            self?.viewModel.patronymic = text
        }
        ui.onEmailTextFieldValueChanged = { [weak self] text in
            self?.viewModel.email = text
        }
        ui.onPhoneNumberTextFieldValueChanged = { [weak self] text in
            self?.viewModel.phoneNumber = text
        }
        ui.onPasswordTextFieldValueChanged = { [weak self] text in
            self?.viewModel.password = text
        }
        ui.onConfirmPasswordTextFieldValueChanged = { [weak self] text in
            self?.viewModel.confirmPassword = text
        }
    }
}
