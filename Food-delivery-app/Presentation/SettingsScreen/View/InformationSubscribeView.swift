//
//  InformationSubscribeView.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit
import SnapKit

class InformationSubscribeView: UIView {

    //MARK: - Private properties
    
    private enum Metrics {
        
    }
    
    private lazy var backgroundImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.secondBackground()
        myImageView.contentMode = .scaleAspectFill
        
        return myImageView
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
    
    private lazy var informationStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        
        return view
    }()
    
    private lazy var startDateSubscribeLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.informationSubcscribeSheetScreen.start_date_subscribe()
        view.textColor = R.color.white()
        view.textAlignment = .left
        view.font = R.font.redHatDisplayMedium(size: 18)
        
        return view
    }()
    
    private lazy var cancelSubscriptionButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle(R.string.informationSubcscribeSheetScreen.cancel_subscription(), for: .normal)
        view.setTitleColor(R.color.textButtonColor(), for: .normal)
        view.titleLabel?.font = R.font.ralewayBold(size: 20)
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 10, bottom: 19, right: 10)
        
        return view
    }()
    
    
    //MARK: - Internal properties
    
    var cancelSubscriptionButtonHandler: (() -> Void)?
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
    
    func setStartDateSubscribe(_ date: String) {
        startDateSubscribeLabel.text = R.string.informationSubcscribeSheetScreen.start_date_subscribe() + date
    }
}


//MARK: - Private extensions

private extension InformationSubscribeView {
    
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
        self.addSubview(informationStack)
        self.addSubview(cancelSubscriptionButton)
        
        informationStack.addArrangedSubview(startDateSubscribeLabel)
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
        
        informationStack.snp.makeConstraints { make in
            make.top.equalTo(titleSheetScreen.snp.bottom).offset(43)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        cancelSubscriptionButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(64)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(37)
        }
    }
    
    func configureActions() {
        arrowBackButton.addTarget(self, action: #selector(arrowBackButtonPressed), for: .touchUpInside)
        cancelSubscriptionButton.addTarget(self, action: #selector(cancelSubscriptionButtonPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Actions
    
    @objc
    func arrowBackButtonPressed() {
        arrowBackButtonHandler?()
    }
    
    @objc
    func cancelSubscriptionButtonPressed() {
        cancelSubscriptionButtonHandler?()
    }
}
