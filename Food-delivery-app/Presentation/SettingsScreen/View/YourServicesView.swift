//
//  YourServicesView.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit
import SnapKit

class YourServicesView: UIView {
    
    //MARK: - Private properties
    
    private enum Metrics {
        
    }
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = R.image.secondBackground()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var arrowBackButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.arrowBackSheet(), for: .normal)
        
        return view
    }()
    
    private lazy var titleSheetScreen: UILabel = {
        let view = UILabel()
        view.text = R.string.yourServicesViewScreen.title_screen()
        view.textColor = R.color.white()
        view.textAlignment = .center
        view.font = R.font.ralewayBold(size: 20)
        
        return view
    }()
    
    private lazy var plusButton: UIButton = {
        let view = UIButton()
        view.setImage(R.image.plusService(), for: .normal)
        
        return view
    }()
    
    private lazy var serviceTags = ServiceTagLabelsView()

	private lazy var plugSubscribeImageView: UIImageView = {
		let view = UIImageView()
		view.image = R.image.notSubscribe()
		view.contentMode = .scaleAspectFit

		return view
	}()

	private lazy var plugEmptyServicesImageView: UIImageView = {
		let view = UIImageView()
		view.image = R.image.notServices()
		view.contentMode = .scaleAspectFit

		return view
	}()

	private lazy var plugSubscribeInformationLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.yourServicesViewScreen.there_is_not_subscribe()
		view.textColor = R.color.white()
		view.textAlignment = .center
		view.numberOfLines = .max
		view.font = R.font.redHatDisplaySemiBold(size: 20)

		return view
	}()

	private lazy var plugEmptyServicesInformationLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.yourServicesViewScreen.there_is_not_services()
		view.textColor = R.color.white()
		view.textAlignment = .center
		view.numberOfLines = .max
		view.font = R.font.redHatDisplaySemiBold(size: 20)

		return view
	}()

	private lazy var subscribeButton: UIButton = {
		let view = UIButton()
		view.backgroundColor = .white
		view.setTitle(R.string.informationSubcscribeSheetScreen.subscribe(), for: .normal)
		view.setTitleColor(R.color.textButtonColor(), for: .normal)
		view.titleLabel?.font = R.font.ralewayBold(size: 20)
		view.layer.cornerRadius = 30
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 20, bottom: 19, right: 20)

		return view
	}()
    
    
    //MARK: - Internal properties
    
    var plusServiceButtonHandler: (() -> Void)?
    var arrowBackButtonHandler: (() -> Void)?
	var subscribeButtonHandler: (() -> Void)?
	var onServiceTagTapped: ((ServiceShortModel) -> ())?
    
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

		setHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Internal methods
    
    func setServices(_ services: [ServiceModel]) {
        serviceTags.services = services
    }
}

//MARK: - Setup extsnion

extension YourServicesView {
	func setupPlugSubscribe() {
		configureUIPlugSubscribe()
		configureConstraintsPlugSubscribe()
		configureActionsPlugSubscribe()
	}

	func setupPlugEmptyServices() {
		configureUIPlugEmptyServices()
		configureConstraintsPlugEmptyServices()
		configureActionsPlugEmptySubscribe()
	}

	func setupScreen() {
		configureUI()
		configureConstraints()
		configureActions()
	}
}


private extension YourServicesView {
    
    func configureUI() {
		for view in self.subviews {
			view.removeFromSuperview()
		}

        self.addSubview(backgroundImage)
        self.addSubview(arrowBackButton)
        self.addSubview(titleSheetScreen)
        self.addSubview(plusButton)
        self.addSubview(serviceTags)
    }

	func configureUIPlugSubscribe() {
		for view in self.subviews {
			view.removeFromSuperview()
		}

		self.addSubview(backgroundImage)
		self.addSubview(arrowBackButton)
		self.addSubview(titleSheetScreen)
		self.addSubview(plugSubscribeImageView)
		self.addSubview(plugSubscribeInformationLabel)
		self.addSubview(subscribeButton)
	}

	func configureUIPlugEmptyServices() {
		for view in self.subviews {
			view.removeFromSuperview()
		}

		self.addSubview(backgroundImage)
		self.addSubview(arrowBackButton)
		self.addSubview(titleSheetScreen)
		self.addSubview(plusButton)
		self.addSubview(plugEmptyServicesImageView)
		self.addSubview(plugEmptyServicesInformationLabel)
	}
    
    func configureConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        arrowBackButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(21)
        }
        
        titleSheetScreen.snp.makeConstraints { make in
            make.centerY.equalTo(arrowBackButton.snp.centerY)
            make.leading.equalTo(arrowBackButton.snp.trailing).offset(14)
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleSheetScreen.snp.centerY)
            make.leading.greaterThanOrEqualTo(titleSheetScreen.snp.trailing).offset(14)
        }
        
        serviceTags.snp.makeConstraints { make in
            make.top.equalTo(titleSheetScreen.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }

	func configureConstraintsPlugSubscribe() {
		backgroundImage.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		arrowBackButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(10)
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(21)
		}

		titleSheetScreen.snp.makeConstraints { make in
			make.centerY.equalTo(arrowBackButton.snp.centerY)
			make.leading.equalTo(arrowBackButton.snp.trailing).offset(14)
		}

		plugSubscribeImageView.snp.makeConstraints { make in
			make.top.equalTo(titleSheetScreen.snp.bottom).offset(50)
			make.centerX.equalToSuperview()
		}

		plugSubscribeInformationLabel.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(15)
			make.top.equalTo(plugSubscribeImageView.snp.bottom).offset(26)
		}

		subscribeButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(plugSubscribeInformationLabel.snp.bottom).offset(33)
		}
	}

	func configureConstraintsPlugEmptyServices() {
		backgroundImage.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		arrowBackButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(10)
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(21)
		}

		titleSheetScreen.snp.makeConstraints { make in
			make.centerY.equalTo(arrowBackButton.snp.centerY)
			make.leading.equalTo(arrowBackButton.snp.trailing).offset(14)
		}

		plusButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(10)
			make.centerY.equalTo(titleSheetScreen.snp.centerY)
			make.leading.greaterThanOrEqualTo(titleSheetScreen.snp.trailing).offset(14)
		}

		plugEmptyServicesImageView.snp.makeConstraints { make in
			make.top.equalTo(titleSheetScreen.snp.bottom).offset(50)
			make.centerX.equalToSuperview()
		}

		plugEmptyServicesInformationLabel.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(15)
			make.top.equalTo(plugEmptyServicesImageView.snp.bottom).offset(26)
		}
	}
    
    func configureActions() {
        arrowBackButton.addTarget(self, action: #selector(arrowBackButtonPressed), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusServiceButtonPressed), for: .touchUpInside)
    }

	func configureActionsPlugSubscribe() {
		subscribeButton.addTarget(self, action: #selector(subscribeButtonPressed), for: .touchUpInside)
	}

	func configureActionsPlugEmptySubscribe() {
		plusButton.addTarget(self, action: #selector(plusServiceButtonPressed), for: .touchUpInside)
	}
    
    //MARK: - Actions
    
    @objc
    func arrowBackButtonPressed() {
        arrowBackButtonHandler?()
    }
    
    @objc
    func plusServiceButtonPressed() {
        plusServiceButtonHandler?()
    }

	@objc
	func subscribeButtonPressed() {
		subscribeButtonHandler?()
	}
}

private extension YourServicesView {
	func setHandlers() {
		serviceTags.onServiceTagTapped = { [ weak self ] shortModel in
			guard let self = self else { return }

			self.onServiceTagTapped?(shortModel)
		}
	}
}
