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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.errors.ok(), style: .default, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }
}

