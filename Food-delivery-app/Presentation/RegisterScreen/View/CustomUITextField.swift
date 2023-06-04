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
        view.background = UIImage(named: "TextFieldBackground")
        
        view.isSecureTextEntry = isSecured
        
        view.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : R.color.authPlaceholderTextFieldColor() ?? .black])
        
        view.layer.cornerRadius = Metrics.authTextFieldCornerRadius
        
        return view
    }
}
