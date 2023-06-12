//
//  StartView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit

final class StartView: UIView {

    var onLoginButtonTapped: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupBackgroundImage()
        setupGreetingContentImage()
        setupGoButton()
    }
    
    // MARK: - BackgroundImage setup
    private lazy var backgroundImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.background1()
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    
    private func setupBackgroundImage() {
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - GreetingContentImage setup
    private lazy var greetingContentImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.greetingImage()
        return myImageView
    }()
    
    private func setupGreetingContentImage() {
        addSubview(greetingContentImage)
        greetingContentImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - GoButton setup
    
    private lazy var goButton: FilledButton = {
        let myButton = FilledButton(labelText: R.string.startScreen.go())
        myButton.addTarget(self, action: #selector(onGoButtonTapped), for: .touchUpInside)
        return myButton
    }()
    
    private func setupGoButton() {
        addSubview(goButton)
        goButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.horizontalEdges.equalToSuperview().inset(100)
        }
    }
    
    @objc func onGoButtonTapped() {
        (onLoginButtonTapped ?? {})()
    }

}
