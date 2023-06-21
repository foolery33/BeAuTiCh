//
//  DetailsAppointmentView.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import UIKit
import SnapKit

class DetailsAppointmentView: UIView {

    // MARK: - Internal properties
    var onBackArrowButtonTapped: (() -> ())?
    var onClientAcceptedButtonTapped: (() -> ())?
    var onCancelAppointmentButtonTapped: (() -> ())?
    
	// MARK: - Private properties
	private lazy var backgroundImage: UIImageView = {
		let view = UIImageView()
		view.image = R.image.background2()
		view.contentMode = .scaleAspectFill
        
		return view
	}()

	private lazy var scrollView: UIScrollView = {
		let view = UIScrollView()
		view.showsVerticalScrollIndicator = false
		view.alwaysBounceVertical = true
		view.frame = self.bounds
		view.contentInsetAdjustmentBehavior = .never
		return view
	}()

	private lazy var contentView: UIView = {
		let view = UIView()
		return view
	}()

	private lazy var arrowBackButton: UIButton = {
		let view = UIButton()
		view.setImage(R.image.arrowBackSheet(), for: .normal)
        view.addTarget(self, action: #selector(backArrowButtonTapped), for: .touchUpInside)
        
		return view
	}()

	private lazy var clientName: UILabel = {
		let view = UILabel()
		view.text = R.string.informationSubcscribeSheetScreen.title_screen()
		view.textColor = R.color.white()
		view.textAlignment = .center
		view.numberOfLines = .max
		view.font = R.font.ralewayBold(size: 30)

		return view
	}()

	private lazy var servicesTitleLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.detailsAppointmentScreen.services()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var serviceTags = ServiceTagsAppointmentView()

	private lazy var informationTitleStack: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.spacing = 18

		return view
	}()

	private lazy var startTimeAppointmentTitleLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.detailsAppointmentScreen.start_time_appointment()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var endTimeAppointmentTitleLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.detailsAppointmentScreen.end_time_appointment()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var phoneTitleLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.detailsAppointmentScreen.phone()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var informationAppointmentStack: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.spacing = 18

		return view
	}()

	private lazy var startTimeAppointmentLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.detailsAppointmentScreen.phone()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayRegular(size: 18)

		return view
	}()

	private lazy var endTimeAppointmentLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.detailsAppointmentScreen.phone()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayRegular(size: 18)

		return view
	}()

	private lazy var phoneLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.detailsAppointmentScreen.phone()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayRegular(size: 18)

		return view
	}()

	private lazy var statusAppointment: UIButton = {
		let view = UIButton()
		view.backgroundColor = .white
		view.isUserInteractionEnabled = false
		view.titleLabel?.numberOfLines = .max
		view.titleLabel?.font = R.font.ralewayBold(size: 13)
		view.layer.cornerRadius = 28
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 10, bottom: 19, right: 10)

		return view
	}()

	private lazy var clientAcceptedButton: UIButton = {
		let view = UIButton()
		view.backgroundColor = R.color.white()
		view.setTitle(R.string.detailsAppointmentScreen.client_accepted(), for: .normal)
		view.setTitleColor(R.color.textButtonColor(), for: .normal)
		view.titleLabel?.numberOfLines = .max
		view.titleLabel?.textAlignment = .center
		view.titleLabel?.font = R.font.ralewayRegular(size: 12)
		view.layer.cornerRadius = 25
		view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 10, bottom: 19, right: 10)
        view.addTarget(self, action: #selector(clientAcceptedButtonTapped), for: .touchUpInside)

		return view
	}()

	private lazy var cancelAppointmentButton: UIButton = {
		let view = UIButton()
		view.backgroundColor = R.color.vinous()
		view.setTitle(R.string.detailsAppointmentScreen.cancel_appointment(), for: .normal)
		view.setTitleColor(R.color.white(), for: .normal)
		view.titleLabel?.font = R.font.ralewayRegular(size: 12)
		view.titleLabel?.numberOfLines = .max
		view.titleLabel?.textAlignment = .center
		view.layer.cornerRadius = 25
		view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 10, bottom: 19, right: 10)
        view.addTarget(self, action: #selector(cancelAppointmentButtonTapped), for: .touchUpInside)

		return view
	}()

	private lazy var changeDataButton: UIButton = {
		let view = UIButton()
		view.backgroundColor = .white
		view.setTitle(R.string.detailsAppointmentScreen.change_data(), for: .normal)
		view.setTitleColor(R.color.textButtonColor(), for: .normal)
		view.titleLabel?.font = R.font.ralewayBold(size: 20)
		view.layer.cornerRadius = 30
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 10, bottom: 19, right: 10)

		return view
	}()

	// MARK: Internal properties

	// MARK: Init
	init() {
		super.init(frame: .zero)

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Configure
	func configure(with model: AppointmentModel) {
		clientName.text = model.clientName
		serviceTags.services = model.services
		startTimeAppointmentLabel.text = model.startDateTime
		endTimeAppointmentLabel.text = model.endDateTime

		if let phone = model.clientPhone{
			addPhoneView(phone: phone)
		}

		switch model.status {
		case .new:
			addButtonsForStatusAppointment()
		case .completed:
			addViewStatusAppointment(statusText: R.string.detailsAppointmentScreen.completed_status(),
									 backgroundColor: R.color.white(),
									 textColor: R.color.textButtonColor())
		case .cancelled:
			addViewStatusAppointment(statusText: R.string.detailsAppointmentScreen.cancelled_status(),
									 backgroundColor: R.color.vinous(),
									 textColor: R.color.white())
		}
	}

	private func addPhoneView(phone: String) {
		informationTitleStack.addArrangedSubview(phoneTitleLabel)
		informationAppointmentStack.addArrangedSubview(phoneLabel)

		phoneLabel.text = phone
	}

	private func addButtonsForStatusAppointment() {
		contentView.addSubview(clientAcceptedButton)
		contentView.addSubview(cancelAppointmentButton)

		clientAcceptedButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(21)
			make.top.equalTo(informationTitleStack.snp.bottom).offset(20)
			make.width.equalTo(89)
		}

		cancelAppointmentButton.snp.makeConstraints { make in
			make.top.equalTo(clientAcceptedButton.snp.top)
			make.trailing.equalToSuperview().inset(20)
			make.width.equalTo(89)
		}

		changeDataButton.snp.remakeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(55)
			make.top.greaterThanOrEqualTo(clientAcceptedButton.snp.bottom).offset(35)
			make.bottom.equalToSuperview().inset(10)
		}
	}

	private func addViewStatusAppointment(statusText: String, backgroundColor: UIColor?, textColor: UIColor?) {
		contentView.addSubview(statusAppointment)

		statusAppointment.setTitle(statusText, for: .normal)
		statusAppointment.backgroundColor = backgroundColor
		statusAppointment.setTitleColor(textColor, for: .normal)

		statusAppointment.snp.makeConstraints { make in
			make.top.equalTo(informationTitleStack.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(110)
		}

		changeDataButton.snp.remakeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(55)
			make.top.greaterThanOrEqualTo(statusAppointment.snp.bottom).offset(16)
			make.bottom.equalToSuperview().inset(10)
		}
	}
    
    @objc private func backArrowButtonTapped() {
        onBackArrowButtonTapped?()
    }
    
    @objc private func clientAcceptedButtonTapped() {
        onClientAcceptedButtonTapped?()
    }
    
    @objc private func cancelAppointmentButtonTapped() {
        onCancelAppointmentButtonTapped?()
    }
    
}

// MARK: - Setup extension
private extension DetailsAppointmentView {
	func setup() {
		configureUI()
		configureConstraints()
		configureActions()
	}

	func configureUI() {
		addSubview(backgroundImage)
		addSubview(scrollView)
		addSubview(arrowBackButton)
		addSubview(clientName)

		scrollView.addSubview(contentView)

		contentView.addSubview(servicesTitleLabel)
		contentView.addSubview(serviceTags)
		contentView.addSubview(informationTitleStack)
		contentView.addSubview(informationAppointmentStack)
		contentView.addSubview(changeDataButton)

		informationTitleStack.addArrangedSubview(startTimeAppointmentTitleLabel)
		informationTitleStack.addArrangedSubview(endTimeAppointmentTitleLabel)

		informationAppointmentStack.addArrangedSubview(startTimeAppointmentLabel)
		informationAppointmentStack.addArrangedSubview(endTimeAppointmentLabel)
	}

	func configureConstraints() {
		backgroundImage.snp.makeConstraints { make in
			make.verticalEdges.equalTo(self.safeAreaLayoutGuide.snp.verticalEdges)
			make.horizontalEdges.equalToSuperview()
		}

		scrollView.snp.makeConstraints { make in
			make.top.equalTo(clientName.snp.bottom).offset(20)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(20)
			make.horizontalEdges.equalToSuperview()
		}

		contentView.snp.makeConstraints { make in
			make.horizontalEdges.equalTo(scrollView.frameLayoutGuide)
			make.top.equalToSuperview()
			make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
		}

		arrowBackButton.snp.makeConstraints { make in
			make.centerY.equalTo(clientName.snp.centerY)
			make.leading.equalToSuperview().inset(10)
		}

		clientName.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(10)
			make.centerX.equalToSuperview()
			make.leading.equalTo(arrowBackButton.snp.trailing)
			make.trailing.equalToSuperview().inset(35)
		}

		servicesTitleLabel.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(21)
			make.top.equalToSuperview()
		}

		serviceTags.snp.makeConstraints { make in
			make.horizontalEdges.equalTo(servicesTitleLabel.snp.horizontalEdges).inset(11)
			make.top.equalTo(servicesTitleLabel.snp.bottom).offset(15)
		}

		informationTitleStack.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(21)
			make.top.equalTo(serviceTags.snp.bottom).offset(20)
		}

		informationAppointmentStack.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(21)
			make.leading.equalTo(informationTitleStack.snp.trailing).offset(15)
			make.top.equalTo(informationTitleStack.snp.top)
		}

		changeDataButton.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(55)
			make.top.greaterThanOrEqualTo(informationAppointmentStack.snp.bottom).offset(16)
			make.bottom.equalToSuperview().inset(10)
		}
	}

	func configureActions() {

	}
}
