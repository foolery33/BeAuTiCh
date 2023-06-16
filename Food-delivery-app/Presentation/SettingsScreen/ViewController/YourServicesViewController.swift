//
//  YourServicesViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

class YourServicesViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let ui: YourServicesView
    
    
    //MARK: - Internal properties
    
    weak var delegate: SheetViewControllerDelegate?
    var viewModel: SettingsViewModel
    
    
    //MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        ui = YourServicesView()
        self.viewModel = viewModel
        
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
        ui.setServices([
            Service(id: "1", name: "Blablabla", price: 12, duration: ""),
            Service(id: "1", name: "bla", price: 12, duration: ""),
            Service(id: "1", name: "jsdfsdfsdf", price: 12, duration: ""),
            Service(id: "1", name: "Blablabla", price: 12, duration: ""),
            Service(id: "1", name: "bla", price: 12, duration: ""),
            Service(id: "1", name: "Blablabla", price: 12, duration: ""),
            Service(id: "1", name: "bla", price: 12, duration: ""),
        ])
    }
    
    
    //MARK: - Private methods
    
    private func dismiss() {
        delegate?.didDismissSheetViewController()
        dismiss(animated: true, completion: nil)
    }
}

private extension YourServicesViewController {
    func setHandlers() {
        ui.arrowBackButtonHandler = { [ weak self ] in
            guard let self = self else { return }
            
            self.dismiss()
        }
        
        ui.plusServiceButtonHandler = { [ weak self ] in
            guard let self = self else { return }
            
        }
    }
}
