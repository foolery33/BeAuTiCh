//
//  LoginView.swift
//  Food-delivery-app
//
//  Created by Елена on 05.06.2023.
//

import UIKit
import SnapKit

class LoginView: UIView {

    //- MARK: Private properties
    
    private enum Metrics {
        static let welcomeLabelTextSize: CGFloat = 32
        
        static let inputFieldsStackSpacing: CGFloat = 15
        
        static let buttonsStackSpacing: CGFloat = 10
        
        static let loginButtonTextSize: CGFloat = 20
        static let loginButtonCornerRadius: CGFloat = 25
        static let loginButtonEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
        
        static let goToRegisterScreenButtonTextsize: CGFloat = 20
        
        static let logoImageSize: CGFloat = 20 * UIScreen.main.bounds.size.height / 100
        
        static let welcomeLabelTopOffset: CGFloat = 5 * UIScreen.main.bounds.size.height / 100
        static let welcomeLabelHorizontalInsets: CGFloat = 17
        static let welcomeLabelHeight: CGFloat = 48
        
        static let inputFieldsStackTopOffset: CGFloat = 3 * UIScreen.main.bounds.size.height / 100
        static let inputFieldsStackHorizontalInsets: CGFloat = 38
        
        static let buttonsStackHorizontalInsets: CGFloat = 46
        static let buttonsStackBottomInsets: CGFloat = 29
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.firstBackground()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.logo()
        
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.loginScreen.repeat_greeting()
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = .max
        view.font = R.font.redHatDisplayBlack(size: Metrics.welcomeLabelTextSize)
        
        return view
    }()
    
    private lazy var inputFieldsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Metrics.inputFieldsStackSpacing
        
        return view
    }()
    
    private lazy var emailTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: false, currentText: "", placeholderText: R.string.loginScreen.input_email())
        return view
    }()
    
    private lazy var passwordTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: true, currentText: "", placeholderText: R.string.loginScreen.input_password())
        return view
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Metrics.buttonsStackSpacing
        
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle(R.string.loginScreen.login(), for: .normal)
        view.setTitleColor(R.color.textButtonColor(), for: .normal)
        view.titleLabel?.font = R.font.ralewayBold(size: Metrics.loginButtonTextSize)
        view.layer.cornerRadius = Metrics.loginButtonCornerRadius
        view.layer.masksToBounds = true
        view.contentEdgeInsets = Metrics.loginButtonEdgeInsets
        
        return view
    }()
    
    private lazy var goToRegisterScreenButton: UIButton = {
        let view = UIButton()
        view.setTitle(R.string.loginScreen.have_not_account(), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = R.font.ralewayRegular(size: Metrics.goToRegisterScreenButtonTextsize)
        
        return view
    }()
    
    
    //- MARK: Public properties
    
    var loginButtonHandler: (() -> Void)?
    var goToRegisterScreenButtonHandler: (() -> Void)?
    
    
    //- MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//- MARK: Private extension

private extension LoginView {
    
    //- MARK: Setup
    
    func setup() {
        configureUI()
        configureConstraints()
        configureAction()
    }
    
    func configureUI() {
        self.addSubview(backgroundImageView)
        self.addSubview(logoImageView)
        self.addSubview(welcomeLabel)
        self.addSubview(inputFieldsStack)
        self.addSubview(buttonsStack)
        
        inputFieldsStack.addArrangedSubview(emailTextField)
        inputFieldsStack.addArrangedSubview(passwordTextField)
        
        buttonsStack.addArrangedSubview(loginButton)
        buttonsStack.addArrangedSubview(goToRegisterScreenButton)
    }
    
    func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide.snp.verticalEdges)
            make.horizontalEdges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(Metrics.logoImageSize)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(Metrics.welcomeLabelTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Metrics.welcomeLabelHorizontalInsets)
            make.height.equalTo(Metrics.welcomeLabelHeight)
        }
        
        inputFieldsStack.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(Metrics.inputFieldsStackTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Metrics.inputFieldsStackHorizontalInsets)
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Metrics.buttonsStackHorizontalInsets)
            make.bottom.equalToSuperview().inset(Metrics.buttonsStackBottomInsets)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(47)
        }
    }
    
    func configureAction() {
        loginButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        goToRegisterScreenButton.addTarget(self, action: #selector(goToRegisterScreenButtonPressed), for: .touchUpInside)
    }
    
    
    //- MARK: Actions
    
    @objc
    func registerButtonPressed() {
        loginButtonHandler?()
    }
    
    @objc
    func goToRegisterScreenButtonPressed() {
        goToRegisterScreenButtonHandler?()
    }
}
