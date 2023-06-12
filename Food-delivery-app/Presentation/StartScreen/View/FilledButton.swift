//
//  FilledButton.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit

class FilledButton: UIButton {

    private enum Metrics {
        static var buttonTextSize: CGFloat = 20
        static var buttonCornerRadius: CGFloat = 25
        static var buttonEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    private let labelText: String
    
    init(labelText: String) {
        self.labelText = labelText
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        backgroundColor = .white
        setTitle(R.string.loginScreen.login(), for: .normal)
        setTitleColor(R.color.textButtonColor(), for: .normal)
        titleLabel?.font = R.font.ralewayBold(size: Metrics.buttonTextSize)
        layer.cornerRadius = Metrics.buttonCornerRadius
        layer.masksToBounds = true
        contentEdgeInsets = Metrics.buttonEdgeInsets
    }
    
}
