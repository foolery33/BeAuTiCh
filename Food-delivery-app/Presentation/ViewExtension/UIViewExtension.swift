//
//  UIViewExtension.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import UIKit

extension UIView {
    func addKeyboardDidmiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    // MARK: - ActiviryIndicator
    func setupActivityIndicator(withBackground: Bool = true) {
        let activityIndicator = ActivityIndicator(withBackground: withBackground)
        self.addSubview(activityIndicator)
        activityIndicator.setupAnimation()
    }
    func stopActivityIndicator() {
        for subview in self.subviews {
            if subview is ActivityIndicator {
                let activityIndicator = subview as! ActivityIndicator
                activityIndicator.stopAnimation()
            }
        }
    }
    
}
