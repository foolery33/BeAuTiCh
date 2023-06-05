//
//  CustomUITextField.swift
//  Food-delivery-app
//
//  Created by Елена on 04.06.2023.
//

import UIKit

class CustomUITextField: UITextField {
    
    //- MARK: Private properties
    
    private enum Metrics {
        static var paddingEdgeInsets = UIEdgeInsets(top: 13, left: 9, bottom: 13, right: 9)
        static var authTextFieldtextSize: CGFloat = 14
        static var authTextFieldCornerRadius: CGFloat = 20
    }
    
    
    //- MARK: Public properties
    
    var padding = Metrics.paddingEdgeInsets
    
    
    //- MARK: Override methods
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    
    //- MARK: Public methods
    
    func getCustomAuthTextField(placeholder: String, isSecured: Bool) -> CustomUITextField {
        
        let view = CustomUITextField()
        view.textColor = R.color.authTextFieldColor()
        view.textAlignment = .left
        view.font = R.font.redHatDisplayMedium(size: Metrics.authTextFieldtextSize)
        view.background = R.image.textFieldBackground()
        
        view.isSecureTextEntry = isSecured
        
        view.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : R.color.authPlaceholderTextFieldColor() ?? .black])
        
        view.layer.cornerRadius = Metrics.authTextFieldCornerRadius
        view.layer.masksToBounds = true
        
        if isSecured {
            view.textContentType = .password
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))

            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 24))
            button.setImage(R.image.hidePassword(), for: .normal)
            button.setImage(R.image.showPassword(), for: .selected)

            paddingView.addSubview(button)
            
            view.rightView = paddingView
            view.rightViewMode = .always
        
            button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
        }
        
        return view
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = sender.isSelected
        self.isSecureTextEntry = sender.isSelected
    }
}
