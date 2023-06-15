//
//  SettingsView.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    
    //MARK: - Private properties
    
    private enum Metrics {
        
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.firstBackground()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var titleScreenLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.settingsScreen.title_screen()
        view.textAlignment = .center
        view.textColor = R.color.white()
        view.font = R.font.ralewayBold(size: 30)
        
        return view
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        
        return view
    }()
    
    private lazy var showServicesView: ShowServicesBlockView = {
        let view = ShowServicesBlockView()
        view.setTextLabel(with: R.string.settingsScreen.show_services())
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var informationSubscriveView: InformationSubscribeBlockView = {
        let view = InformationSubscribeBlockView()
        view.setTextLabel(with: R.string.settingsScreen.information_subscribe())
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    
    //MARK: - Internal properties
    
    var showServicesViewHandler: (() -> Void)?
    var informationSubscriveViewHandler: (() -> Void)?
    
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Private extensions

private extension SettingsView {
    
    //MARK: - Setup
    
    func setup() {
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    func configureUI() {
        self.addSubview(backgroundImageView)
        self.addSubview(titleScreenLabel)
        self.addSubview(buttonsStack)
        
        buttonsStack.addArrangedSubview(showServicesView)
        buttonsStack.addArrangedSubview(informationSubscriveView)
    }
    
    func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleScreenLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(8)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(titleScreenLabel.snp.bottom).offset(20)
        }
    }
    
    func configureActions() {
        showServicesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showServicesViewPressed)))
        informationSubscriveView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(informationSubscriveViewPressed)))
    }
    
    
    //MARK: - Actions
    
    @objc
    func showServicesViewPressed() {
        showServicesViewHandler?()
    }
    
    @objc
    func informationSubscriveViewPressed() {
        informationSubscriveViewHandler?()
    }
}
