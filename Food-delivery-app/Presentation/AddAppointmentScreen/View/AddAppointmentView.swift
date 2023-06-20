//
//  AddAppointment.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import UIKit
import SnapKit

class AddAppointmentView: UIView {

	// MARK: - Private properties
	private lazy var backgroundImage: UIImageView = {
		let view = UIImageView()
		view.image = R.image.background2()
		view.contentMode = .scaleAspectFill

		return view
	}()

	private lazy var arrowBackButton: UIButton = {
		let view = UIButton()
		view.setImage(R.image.arrowBackSheet(), for: .normal)

		return view
	}()

	private lazy var titleScreen: UILabel = {
		let view = UILabel()
		view.text = R.string.addAppointmentScreen.title_screen()
		view.textColor = R.color.white()
		view.textAlignment = .center
		view.numberOfLines = .max
		view.font = R.font.redHatDisplayBlack(size: 30)

		return view
	}()

	private lazy var inputClientNameLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.addAppointmentScreen.input_client_name()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var inputClientNameTextField: CustomUITextField = {
		let view = CustomUITextField(isSecured: false, currentText: String(), placeholderText: R.string.addAppointmentScreen.input_client_name_placeholder())

		return view
	}()

	private lazy var inputDateTimeAppointmentLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.addAppointmentScreen.input_date()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var dateTimeAppointmentTextField: CustomUITextField = {
		let view = CustomUITextField(isSecured: false, currentText: String(), placeholderText: R.string.addAppointmentScreen.input_date_placeholder(), isDate: true)

		return view
	}()

	private lazy var dateTimeAppointmentPicker: UIDatePicker = {
		let view = UIDatePicker()
		view.datePickerMode = .dateAndTime
		view.preferredDatePickerStyle = .wheels
		view.minimumDate = Date()
		return view
	}()

	private lazy var inputClientPhoneLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.addAppointmentScreen.input_phone()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var inputClientPhoneTextField: CustomUITextField = {
		let view = CustomUITextField(isSecured: false, currentText: String(), placeholderText: R.string.addAppointmentScreen.input_phone_placeholder())

		return view
	}()

	private lazy var goToShooseServicesButton: UIButton = {
		let view = UIButton()
		view.backgroundColor = .white
		view.setTitle(R.string.addAppointmentScreen.shoose_services(), for: .normal)
		view.setTitleColor(R.color.vinous(), for: .normal)
		view.titleLabel?.textAlignment = .center
		view.titleLabel?.numberOfLines = .max
		view.titleLabel?.font = R.font.ralewayBold(size: 15)
		view.layer.cornerRadius = 20
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

		return view
	}()

	private lazy var saveButton: UIButton = {
		let view = UIButton()
		view.backgroundColor = .white
		view.setTitle(R.string.addAppointmentScreen.save(), for: .normal)
		view.setTitleColor(R.color.textButtonColor(), for: .normal)
		view.titleLabel?.font = R.font.ralewayBold(size: 20)
		view.layer.cornerRadius = 30
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 10, bottom: 19, right: 10)

		return view
	}()

	// MARK: - Internal properties
	var convertDateToDdMmYyyy: ((Date) -> (String))?
	var arrowBackButtonHandler: (() -> Void)?
	var goToShooseServicesButtonHandler: (() -> Void)?
	var saveButtonHandler: (() -> Void)?

	// MARK: - Init
	init() {
		super.init(frame: .zero)

		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private methods
	private func setDatePickerOnFromDate() {
		let toolbar = UIToolbar()
		toolbar.sizeToFit()

		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onFromDateDoneButtonPressed))
		toolbar.setItems([doneButton], animated: true)

		dateTimeAppointmentTextField.inputAccessoryView = toolbar
		dateTimeAppointmentTextField.inputView = dateTimeAppointmentPicker
	}
}

// MARK: - Setup extension
private extension AddAppointmentView {
	func setup() {
		configureUI()
		configureConstraints()
		configureActions()
		setDatePickerOnFromDate()
	}

	func configureUI() {
		addSubview(backgroundImage)
		addSubview(arrowBackButton)
		addSubview(titleScreen)
		addSubview(inputClientNameLabel)
		addSubview(inputClientNameTextField)
		addSubview(inputDateTimeAppointmentLabel)
		addSubview(dateTimeAppointmentTextField)
		addSubview(inputClientPhoneLabel)
		addSubview(inputClientPhoneTextField)
		addSubview(goToShooseServicesButton)
		addSubview(saveButton)
	}

	func configureConstraints() {
		backgroundImage.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		arrowBackButton.snp.makeConstraints { make in
			make.centerY.equalTo(titleScreen.snp.centerY)
			make.leading.equalToSuperview().inset(10)
		}

		titleScreen.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(10)
			make.centerX.equalToSuperview()
			make.leading.equalTo(arrowBackButton.snp.trailing)
			make.trailing.equalToSuperview().inset(35)
		}

		inputClientNameLabel.snp.makeConstraints { make in
			make.top.equalTo(titleScreen.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(28)
		}

		inputClientNameTextField.snp.makeConstraints { make in
			make.top.equalTo(inputClientNameLabel.snp.bottom).offset(10)
			make.horizontalEdges.equalTo(inputClientNameLabel.snp.horizontalEdges)
		}

		inputDateTimeAppointmentLabel.snp.makeConstraints { make in
			make.top.equalTo(inputClientNameTextField.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(28)
		}

		dateTimeAppointmentTextField.snp.makeConstraints { make in
			make.top.equalTo(inputDateTimeAppointmentLabel.snp.bottom).offset(10)
			make.horizontalEdges.equalTo(inputDateTimeAppointmentLabel.snp.horizontalEdges)
		}

		inputClientPhoneLabel.snp.makeConstraints { make in
			make.top.equalTo(dateTimeAppointmentTextField.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(28)
		}

		inputClientPhoneTextField.snp.makeConstraints { make in
			make.top.equalTo(inputClientPhoneLabel.snp.bottom).offset(10)
			make.horizontalEdges.equalTo(inputClientPhoneLabel.snp.horizontalEdges)
		}

		goToShooseServicesButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(28)
			make.width.equalTo(163)
			make.top.equalTo(inputClientPhoneTextField.snp.bottom).offset(20)
		}

		saveButton.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(55)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(37)
		}
	}

	func configureActions() {
		goToShooseServicesButton.addTarget(self, action: #selector(goToShooseServicesButtonPressed), for: .touchUpInside)
		saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
		arrowBackButton.addTarget(self, action: #selector(arrowBackButtonPressed), for: .touchUpInside)
	}
}

// MARK: - Actions
private extension AddAppointmentView {
	@objc func onFromDateDoneButtonPressed() {
		dateTimeAppointmentTextField.text = (convertDateToDdMmYyyy ?? { _ in return "" })(dateTimeAppointmentPicker.date)
		({ _ in })("\(dateTimeAppointmentPicker.date)")
		endEditing(true)
	}

	@objc func arrowBackButtonPressed() {
		arrowBackButtonHandler?()
	}

	@objc func goToShooseServicesButtonPressed() {
		goToShooseServicesButtonHandler?()
	}

	@objc func saveButtonPressed() {
		saveButtonHandler?()
	}
}
