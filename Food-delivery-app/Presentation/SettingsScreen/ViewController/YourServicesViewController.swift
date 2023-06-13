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
    
    weak var delegate: SheetViewControllerDelegateProtocol?
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
    }
    
    
    //MARK: - Private methods
    
    private func dismiss(imageName: String) {
        delegate?.didDismissSheetViewController()
        dismiss(animated: true, completion: nil)
    }
}
