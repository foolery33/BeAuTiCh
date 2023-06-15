//
//  SettingsBlockView.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit
import SnapKit

class SettingsBlockView: UIView {
    
    //MARK: - Private properties
    
    private enum Metrics {
        
    }
    
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = R.color.white()
        view.font = R.font.redHatDisplayMedium(size: 18)
        
        return view
    }()
    
    private lazy var arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = R.image.arrow()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Internal methods
    
    func showSheet() { }
    
    func setTextLabel(with text: String) {
        textLabel.text = text
    }
}


//MARK: - Private extensions

private extension SettingsBlockView {
    
    //MARK: - Setup
    
    func setup() {
        configureUI()
        configureConstraints()
    }
    
    func configureUI() {
        self.addSubview(textLabel)
        self.addSubview(arrowImage)
    }
    
    func configureConstraints() {
        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
}
