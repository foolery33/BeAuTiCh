//
//  SettingsViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

final class SettingsViewController: UIViewController, SheetViewControllerDelegate {
    
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
    
    
    //MARK: - Public methods
    
    func didDismissSheetViewController() {
        
    }
}


//MARK: - Private extensions

private extension SettingsViewController {
    func setHandlers() {
        ui.showServicesViewHandler = { [ weak self ] in
            guard let self = self else { return }
            
            self.viewModel.goToServicesScreen(delegate: self)
        }
        
        ui.informationSubscriveViewHandler = { [ weak self ] in
            guard let self = self else { return }
            
            self.viewModel.goToInformationSubcribeScreen(delegate: self)
        }
    }
}
