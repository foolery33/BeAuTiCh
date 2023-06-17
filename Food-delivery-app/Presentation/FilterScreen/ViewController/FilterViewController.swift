//
//  FilterViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import UIKit

final class FilterViewController: UIViewController {
    
    private let viewModel: FilterViewModel
    private let ui: FilterView
    
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        self.ui = FilterView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ui
        setupNavigationBarAppearence()
        title = R.string.filterScreen.filters()
        navigationItem.leftBarButtonItem = getNavigationLeftItem()
    }
    
}

private extension FilterViewController {
    private func getNavigationLeftItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: R.image.backNavigationArrow(), style: .plain, target: self, action: #selector(goBackToCreateCollectionScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goBackToCreateCollectionScreen() {
        self.viewModel.goBackToSearchScreen()
    }
}
