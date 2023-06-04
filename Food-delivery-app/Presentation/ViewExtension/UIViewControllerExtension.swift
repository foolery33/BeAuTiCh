//
//  UIViewControllerExtension.swift
//  Food-delivery-app
//
//  Created by Елена on 04.06.2023.
//

import UIKit

extension UIViewController {
    func setupKeyboardDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard(sender:)))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
}

