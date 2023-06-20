//
//  CustomUITextField.swift
//  Food-delivery-app
//
//  Created by Елена on 04.06.2023.
//

import UIKit

class CustomUITextField: UITextField {
    
    private let isSecured: Bool
    private let currentText: String
    private let placeholderText: String
    private let isSmallVersion: Bool?
    
    private enum SystemImages {
        static let eyeSlash = "eye.slash"
        static let eye = "eye"
    }
    
    private enum Paddings {
        static let offset = 16.0
        static let securedTextField = UIEdgeInsets(top: 13.0, left: 9.0, bottom: 13.0, right: 48.0)
        static let textField = UIEdgeInsets(top: 13.0, left: 9.0, bottom: 13.0, right: 9.0)
        static let smallSecuredTextField = UIEdgeInsets(top: 6.0, left: 9.0, bottom: 6.0, right: 48.0)
        static let smallTextField = UIEdgeInsets(top: 6.0, left: 9.0, bottom: 6.0, right: 9.0)
    }
    
    private enum Scales {
        static let fontSize = 14.0
        static let passwordEyeSize = 22.0
        static let bottomLineHeight = 2.0
        static let cornerRadius = 20.0
    }
    
    
    init(isSecured: Bool, currentText: String, placeholderText: String, isSmallVersion: Bool? = false) {
        self.isSecured = isSecured
        self.currentText = currentText
        self.placeholderText = placeholderText
        self.isSmallVersion = isSmallVersion
        super.init(frame: .zero)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if isSmallVersion ?? false {
            return bounds.inset(by: self.isSecured ? Paddings.smallSecuredTextField : Paddings.smallTextField)
        }
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if isSmallVersion ?? false {
            return bounds.inset(by: self.isSecured ? Paddings.smallSecuredTextField : Paddings.smallTextField)
        }
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if isSmallVersion ?? false {
            return bounds.inset(by: self.isSecured ? Paddings.smallSecuredTextField : Paddings.smallTextField)
        }
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = Paddings.offset
        let width  = Int(Scales.passwordEyeSize)
        let height = width
        let x = Int(Int(bounds.width) - Int(width) - Int(offset))
        let y = Int(bounds.height / 2 - Scales.passwordEyeSize / 2)
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
    private func setupTextField() {
        textColor = R.color.authTextFieldColor()
        autocapitalizationType = .none
        font = R.font.redHatDisplayMedium(size: Scales.fontSize)
        background = R.image.textFieldBackground()
        
        isSecureTextEntry = isSecured
        
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : R.color.authPlaceholderTextFieldColor() ?? .black])
        
        layer.cornerRadius = Scales.cornerRadius
        layer.masksToBounds = true
        
        if isSecured {
            rightView = passwordEye
            rightViewMode = .always
            textContentType = .oneTimeCode
        }
    }
    
    // MARK: - PasswordEye setup
    private lazy var passwordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(R.image.hidePassword()!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize), for: .normal)
        eye.setImage(R.image.showPassword()!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize), for: .selected)
        eye.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return eye
    }()
    @objc
    func togglePasswordVisibility(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
    }
    
}
