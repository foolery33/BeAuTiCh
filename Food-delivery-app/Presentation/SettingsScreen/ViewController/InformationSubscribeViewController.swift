//
//  InformationSubscribeViewController.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

class InformationSubscribeViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let ui: InformationSubscribeView
    
    
    //MARK: - Internal properties
    
    weak var delegate: SheetViewControllerDelegate?
    var viewModel: SettingsViewModel
    
    
    //MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        ui = InformationSubscribeView()
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
    }
    
    
    //MARK: - Private methods
    
    private func dismiss() {
        delegate?.didDismissSheetViewController()
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Internal methods
    
    func setStartDateSubscribe(_ date: String) {
        ui.setStartDateSubscribe(date)
    }
}

private extension InformationSubscribeViewController {
    func setHandlers() {
        ui.arrowBackButtonHandler = { [ weak self ] in
            guard let self = self else { return }
            
            self.dismiss()
        }
        
        ui.cancelSubscriptionButtonHandler = { [ weak self ] in
            guard let self = self else { return }
            
        }
    }
}
