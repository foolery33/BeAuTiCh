//
//  ServiceSelectionView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import UIKit

class ServiceSelectionView: UIView {

    //MARK: - Private properties
    
    private enum Metrics {
        
    }
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = R.image.secondBackground()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var arrowBackButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.arrowBackSheet(), for: .normal)
        
        return view
    }()
    
    private lazy var titleSheetScreen: UILabel = {
        let view = UILabel()
        view.text = R.string.serviceSelectionScreen.choose_service()
        view.textColor = R.color.white()
        view.textAlignment = .center
        view.font = R.font.ralewayBold(size: 20)
        
        return view
    }()
    
    private lazy var serviceTags = ServiceTagLabelsView()
    
    
    //MARK: - Internal properties
    
    var arrowBackButtonHandler: (() -> Void)?
    var onServiceTapped: ((UUID) -> ())?
    
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Internal methods
    
    func setServices(_ services: [ServiceModel]) {
        serviceTags.services = services
    }
    
    func setSelectedServiceIds(_ services: [UUID]?) {
        serviceTags.selectedServiceTagIds = services
    }
}


//MARK: - Private extensions

private extension ServiceSelectionView {
    
    //MARK: - Setup
    
    func setup() {
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    func configureUI() {
        self.addSubview(backgroundImage)
        self.addSubview(arrowBackButton)
        self.addSubview(titleSheetScreen)
        self.addSubview(serviceTags)
    }
    
    func configureConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        arrowBackButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(21)
        }
        
        titleSheetScreen.snp.makeConstraints { make in
            make.centerY.equalTo(arrowBackButton.snp.centerY)
            make.leading.equalTo(arrowBackButton.snp.trailing).offset(14)
        }
        
        serviceTags.snp.makeConstraints { make in
            make.top.equalTo(titleSheetScreen.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func configureActions() {
        arrowBackButton.addTarget(self, action: #selector(arrowBackButtonPressed), for: .touchUpInside)
        serviceTags.onServiceTagTapped = { [weak self] id in
            (self?.onServiceTapped ?? { _ in })(id)
        }
    }
    
    
    //MARK: - Actions
    
    @objc
    func arrowBackButtonPressed() {
        arrowBackButtonHandler?()
    }

}
