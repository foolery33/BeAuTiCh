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
        view.font = UIFont(name: "RedHatDisplay-Black", size: 36)
        
        return view
    }()
    
    private var inputFieldsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        
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
        view.spacing = 15
        
        return view
    }()
    
    private var registerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("Зарегистрироваться", for: .normal)
        view.setTitleColor(.textButton, for: .normal)
        view.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 20)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
        
        return view
    }()
    
    private var goToAuthScreenButton: UIButton = {
        let view = UIButton()
        view.setTitle("У меня уже есть аккаунт", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 20)
        
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
            make.size.equalTo(200)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(35)
            make.horizontalEdges.equalToSuperview().inset(17)
            make.height.equalTo(48)
        }
        
        inputFieldsStack.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(38)
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(46)
            make.bottom.equalToSuperview().inset(29)
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
