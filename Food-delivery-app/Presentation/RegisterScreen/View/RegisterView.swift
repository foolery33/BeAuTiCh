//
//  RegisterView.swift
//  Food-delivery-app
//
//  Created by Елена on 03.06.2023.
//

import UIKit
import RswiftResources
import SnapKit

class RegisterView: UIView {
    
    //- MARK: Private properties
    
    private enum Metrics {
        static var welcomeLabelTextSize: CGFloat = 32
        
        static var inputFieldsStackSpacing: CGFloat = 15
        
        static var buttonsStackSpacing: CGFloat = 10
        
        static var registerButtonTextSize: CGFloat = 20
        static var registerButtonCornerRadius: CGFloat = 25
        static var registerButtonEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
        
        static var goToAuthScreenButtonTextsize: CGFloat = 20
        
        static var logoImageSize: CGFloat = 20 * UIScreen.main.bounds.size.height / 100
        
        static var welcomeLabelTopOffset: CGFloat = 5 * UIScreen.main.bounds.size.height / 100
        static var welcomeLabelHorizontalInsets: CGFloat = 17
        static var welcomeLabelHeight: CGFloat = 48
        
        static var inputFieldsStackTopOffset: CGFloat = 3 * UIScreen.main.bounds.size.height / 100
        static var inputFieldsStackHorizontalInsets: CGFloat = 38
        
        static var buttonsStackHorizontalInsets: CGFloat = 46
        static var buttonsStackBottomInsets: CGFloat = 29
    }
    
    private var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.firstBackground()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    
    private var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.logo()
        
        return view
    }()
    
    private var welcomeLabel: UILabel = {
        let view = UILabel()
        view.text = R.string.registerScreen.first_greeting()
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = .max
        view.font = R.font.redHatDisplaySemiBold(size: Metrics.welcomeLabelTextSize)
        
        return view
    }()
    
    private var inputFieldsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Metrics.inputFieldsStackSpacing
        return view
    }()
    
    private lazy var lastNameTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: false, currentText: "", placeholderText: R.string.registerScreen.input_lastname())
        view.addTarget(self, action: #selector(onLastNameDidChange(_:)), for: .editingChanged)
        return view
    }()
    @objc private func onLastNameDidChange(_ textField: UITextField) {
        onLastNameTextFieldValueChanged?(textField.text ?? "")
    }
    
    private lazy var firstNameTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: false, currentText: "", placeholderText: R.string.registerScreen.input_firstname())
        view.addTarget(self, action: #selector(onFirstNameDidChange(_:)), for: .editingChanged)
        return view
    }()
    @objc private func onFirstNameDidChange(_ textField: UITextField) {
        onFirstNameTextFieldValueChanged?(textField.text ?? "")
    }
    
    private lazy var patronymicTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: false, currentText: "", placeholderText: R.string.registerScreen.input_patronymic())
        view.addTarget(self, action: #selector(onPatronymicDidChange(_:)), for: .editingChanged)
        return view
    }()
    @objc private func onPatronymicDidChange(_ textField: UITextField) {
        onPatronymicTextFieldValueChanged?(textField.text ?? "")
    }
    
    private lazy var emailTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: false, currentText: "", placeholderText: R.string.registerScreen.input_email())
        view.addTarget(self, action: #selector(onEmailDidChange(_:)), for: .editingChanged)
        return view
    }()
    @objc private func onEmailDidChange(_ textField: UITextField) {
        onEmailTextFieldValueChanged?(textField.text ?? "")
    }
    
    private lazy var phoneNumberTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: false, currentText: "", placeholderText: R.string.registerScreen.input_phone_number())
        view.addTarget(self, action: #selector(onPhoneNumberDidChange(_:)), for: .editingChanged)
        return view
    }()
    @objc private func onPhoneNumberDidChange(_ textField: UITextField) {
        onPhoneNumberTextFieldValueChanged?(textField.text ?? "")
    }
    
    private lazy var passwordTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: true, currentText: "", placeholderText: R.string.registerScreen.input_password())
        view.addTarget(self, action: #selector(onPasswordDidChange(_:)), for: .editingChanged)
        return view
    }()
    @objc private func onPasswordDidChange(_ textField: UITextField) {
        onPasswordTextFieldValueChanged?(textField.text ?? "")
    }
    
    private lazy var confirmPasswordTextField: CustomUITextField = {
        let view = CustomUITextField(isSecured: true, currentText: "", placeholderText: R.string.registerScreen.input_repeat_password())
        view.addTarget(self, action: #selector(onConfirmPasswordDidChange(_:)), for: .editingChanged)
        return view
    }()
    @objc private func onConfirmPasswordDidChange(_ textField: UITextField) {
        onConfirmPasswordTextFieldValueChanged?(textField.text ?? "")
    }
    
    private lazy var buttonsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Metrics.buttonsStackSpacing
        
        return view
    }()
    
    private lazy var registerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle(R.string.registerScreen.register(), for: .normal)
        view.setTitleColor(R.color.textButtonColor(), for: .normal)
        view.titleLabel?.font = R.font.ralewayBold(size: Metrics.registerButtonTextSize)
        view.layer.cornerRadius = Metrics.registerButtonTextSize
        view.layer.masksToBounds = true
        view.contentEdgeInsets = Metrics.registerButtonEdgeInsets
        
        return view
    }()
    
    private lazy var goToAuthScreenButton: UIButton = {
        let view = UIButton()
        view.setTitle(R.string.registerScreen.have_account(), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = R.font.ralewayRegular(size: Metrics.goToAuthScreenButtonTextsize)
        
        return view
    }()
    
    
    //- MARK: Public properties
    
    var registerButtonHandler: (() -> Void)?
    var goToAuthButtonHandler: (() -> Void)?
    var onLastNameTextFieldValueChanged: ((String) -> ())?
    var onFirstNameTextFieldValueChanged: ((String) -> ())?
    var onPatronymicTextFieldValueChanged: ((String) -> ())?
    var onEmailTextFieldValueChanged: ((String) -> ())?
    var onPhoneNumberTextFieldValueChanged: ((String) -> ())?
    var onPasswordTextFieldValueChanged: ((String) -> ())?
    var onConfirmPasswordTextFieldValueChanged: ((String) -> ())?
    
    
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
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(inputFieldsStack)
        contentView.addSubview(buttonsStack)
        
        inputFieldsStack.addArrangedSubview(lastNameTextField)
        inputFieldsStack.addArrangedSubview(firstNameTextField)
        inputFieldsStack.addArrangedSubview(patronymicTextField)
        inputFieldsStack.addArrangedSubview(passwordTextField)
        inputFieldsStack.addArrangedSubview(emailTextField)
        inputFieldsStack.addArrangedSubview(phoneNumberTextField)
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
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
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
            make.top.greaterThanOrEqualTo(inputFieldsStack.snp.bottom).offset(16)
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
