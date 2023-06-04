//
//  CustomUITextField.swift
//  Food-delivery-app
//
//  Created by Елена on 04.06.2023.
//

import UIKit

class CustomUITextField: UITextField {
    
    //- MARK: Public properties
    
    var padding = UIEdgeInsets(top: 13, left: 9, bottom: 13, right: 9)
    
    
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
        view.textColor = .authTextField
        view.textAlignment = .left
        view.font = UIFont(name: "RedHatDisplay-Medium", size: 14)
        view.background = UIImage(named: "TextFieldBackground")
        
        view.isSecureTextEntry = isSecured
        
        view.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.authPlaceholderTextField])
        
        view.layer.cornerRadius = 20
        
        return view
    }
}
