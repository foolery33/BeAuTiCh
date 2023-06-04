//
//  RegisterView.swift
//  Food-delivery-app
//
//  Created by Елена on 03.06.2023.
//

import UIKit
import SnapKit

class RegisterView: UIView {
    
    //- MARK: Private properties
    
    private enum Metrics {
        static var welcomeLabelTextSize: CGFloat = 36
        
        static var inputFieldsStackSpacing: CGFloat = 20
        
        static var buttonsStackSpacing: CGFloat = 15
        
        static var registerButtonTextSize: CGFloat = 20
        static var registerButtonCornerRadius: CGFloat = 25
        static var registerButtonEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
        
        static var goToAuthScreenButtonTextsize: CGFloat = 20
        
        static var logoImageSize: CGFloat = 200
        
        static var welcomeLabelTopOffset: CGFloat = 35
        static var welcomeLabelHorizontalInsets: CGFloat = 17
        static var welcomeLabelHeight: CGFloat = 48
        
        static var inputFieldsStackTopOffset: CGFloat = 48
        static var inputFieldsStackHorizontalInsets: CGFloat = 38
        
        static var buttonsStackHorizontalInsets: CGFloat = 46
        static var buttonsStackBottomInsets: CGFloat = 29
    }
    
    private var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "FirstBackground")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo")
        
        return view
    }()
    
    private var welcomeLabel: UILabel = {
        let view = UILabel()
        view.text = "Добро пожаловать!"
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont(name: "RedHatDisplay-Black", size: Metrics.welcomeLabelTextSize)
        
        return view
    }()
    
    private var inputFieldsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Metrics.inputFieldsStackSpacing
        
        return view
    }()
    
    private var lastNameTextField: CustomUITextField = {
        var view = CustomUITextField()
        view = view.getCustomAuthTextField(placeholder: "Введите фамилию*", isSecured: false)
        
        return view
    }()
    
    private var firstNameTextField: CustomUITextField = {
        var view = CustomUITextField()
        view = view.getCustomAuthTextField(placeholder: "Введите имя*", isSecured: false)
        
        return view
    }()
    
    private var patronymicTextField: CustomUITextField = {
        var view = CustomUITextField()
        view = view.getCustomAuthTextField(placeholder: "Введите отчество", isSecured: false)
        
        return view
    }()
    
    private var emailTextField: CustomUITextField = {
        var view = CustomUITextField()
        view = view.getCustomAuthTextField(placeholder: "Введите email*", isSecured: false)
        
        return view
    }()
    
    private var passwordTextField: CustomUITextField = {
        var view = CustomUITextField()
        view = view.getCustomAuthTextField(placeholder: "Введите пароль*", isSecured: false)
        
        return view
    }()
    
    private var confirmPasswordTextField: CustomUITextField = {
        var view = CustomUITextField()
        view = view.getCustomAuthTextField(placeholder: "Повторите пароль*", isSecured: false)
        
        return view
    }()
    
    private var buttonsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Metrics.buttonsStackSpacing
        
        return view
    }()
    
    private var registerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("Зарегистрироваться", for: .normal)
        view.setTitleColor(.textButton, for: .normal)
        view.titleLabel?.font = UIFont(name: "Raleway-Bold", size: Metrics.registerButtonTextSize)
        view.layer.cornerRadius = Metrics.registerButtonTextSize
        view.layer.masksToBounds = true
        view.contentEdgeInsets = Metrics.registerButtonEdgeInsets
        
        return view
    }()
    
    private var goToAuthScreenButton: UIButton = {
        let view = UIButton()
        view.setTitle("У меня уже есть аккаунт", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont(name: "Raleway-Regular", size: Metrics.goToAuthScreenButtonTextsize)
        
        return view
    }()
    
    
    //- MARK: Public properties
    
    var registerButtonHandler: (() -> Void)?
    var goToAuthButtonHandler: (() -> Void)?
    
    
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

private extension RegisterView {
    
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
        
        inputFieldsStack.addArrangedSubview(lastNameTextField)
        inputFieldsStack.addArrangedSubview(firstNameTextField)
        inputFieldsStack.addArrangedSubview(passwordTextField)
        inputFieldsStack.addArrangedSubview(emailTextField)
        inputFieldsStack.addArrangedSubview(passwordTextField)
        inputFieldsStack.addArrangedSubview(confirmPasswordTextField)
        
        buttonsStack.addArrangedSubview(registerButton)
        buttonsStack.addArrangedSubview(goToAuthScreenButton)
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
    }
    
    func configureAction() {
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        goToAuthScreenButton.addTarget(self, action: #selector(goToAuthScreenButtonPressed), for: .touchUpInside)
    }
    
    
    //- MARK: Actions
    
    @objc
    func registerButtonPressed() {
        registerButtonHandler?()
    }
    
    @objc
    func goToAuthScreenButtonPressed() {
        goToAuthButtonHandler?()
    }
}
