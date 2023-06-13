//
//  SettingsViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let viewModel: SettingsViewModel
    private let ui: SettingsView
    
    
    //MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        ui = SettingsView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle
    
    override func loadView() {
        self.view = ui
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHandlers()
    }
}


//MARK: - Private extensions

private extension SettingsViewController {
    func setHandlers() {
        
    }
}
