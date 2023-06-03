//
//  RegisterViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 03.06.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let viewModel: RegisterViewModel
    private let ui: RegisterView
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        self.ui = RegisterView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
