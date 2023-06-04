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
        
        setupToHideKeyboardOnTapOnView()
        setHandlers()
    }
}

private extension RegisterViewController {
    func setHandlers() {
        ui.registerButtonHandler = { [weak self] in
            guard let self = self else { return }
        }
        
        ui.goToAuthButtonHandler = { [weak self] in
            guard let self = self else { return }
        }
    }
}
