//
//  YourServicesView.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit
import SnapKit

class YourServicesView: UIView {
    
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
        view.text = R.string.informationSubcscribeSheetScreen.title_screen()
        view.textColor = R.color.white()
        view.textAlignment = .center
        view.font = R.font.ralewayBold(size: 20)
        
        return view
    }()
    
    private lazy var plusButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.plusService(), for: .normal)
        
        return view
    }()
    
    private lazy var serviceTags = ServiceTagLabelsView()
    
    
    //MARK: - Internal properties
    
    var plusServiceButtonHandler: (() -> Void)?
    var arrowBackButtonHandler: (() -> Void)?
    
    
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
}


//MARK: - Private extensions

private extension YourServicesView {
    
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
        self.addSubview(plusButton)
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
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleSheetScreen.snp.centerY)
            make.leading.greaterThanOrEqualTo(titleSheetScreen.snp.trailing).offset(14)
        }
        
        serviceTags.snp.makeConstraints { make in
            make.top.equalTo(titleSheetScreen.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func configureActions() {
        arrowBackButton.addTarget(self, action: #selector(arrowBackButtonPressed), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusServiceButtonPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Actions
    
    @objc
    func arrowBackButtonPressed() {
        arrowBackButtonHandler?()
    }
    
    @objc
    func plusServiceButtonPressed() {
        plusServiceButtonHandler?()
    }
}
