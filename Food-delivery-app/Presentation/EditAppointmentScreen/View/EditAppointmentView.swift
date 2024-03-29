//
//  EditAppointmentView.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import UIKit

class EditAppointmentView: UIView {

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
		view.text = R.string.editAppointmentScreen.title_screen()
		view.textColor = R.color.white()
		view.textAlignment = .center
		view.numberOfLines = .max
		view.font = R.font.redHatDisplayBlack(size: 30)

		return view
	}()

	private lazy var inputClientNameLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.editAppointmentScreen.input_client_name()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var inputClientNameTextField: CustomUITextField = {
		let view = CustomUITextField(isSecured: false, currentText: String(), placeholderText: R.string.editAppointmentScreen.input_client_name_placeholder())

		return view
	}()

	private lazy var inputDateTimeAppointmentLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.editAppointmentScreen.input_date()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var dateTimeAppointmentTextField: CustomUITextField = {
		let view = CustomUITextField(isSecured: false, currentText: String(), placeholderText: R.string.editAppointmentScreen.input_date_placeholder(), isDate: true)

		return view
	}()

	private lazy var dateTimeAppointmentPicker: UIDatePicker = {
		let view = UIDatePicker()
		view.datePickerMode = .dateAndTime
		view.preferredDatePickerStyle = .wheels
		return view
	}()

	private lazy var inputClientPhoneLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.editAppointmentScreen.input_phone()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var inputClientPhoneTextField: CustomUITextField = {
		let view = CustomUITextField(isSecured: false, currentText: String(), placeholderText: R.string.editAppointmentScreen.input_phone_placeholder())

		return view
	}()

	private lazy var goToChooseServicesButton: UIButton = {
		let view = UIButton()
		view.backgroundColor = .white
		view.setTitle(R.string.editAppointmentScreen.shoose_services(), for: .normal)
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
		view.setTitle(R.string.editAppointmentScreen.save(), for: .normal)
		view.setTitleColor(R.color.textButtonColor(), for: .normal)
		view.titleLabel?.font = R.font.ralewayBold(size: 20)
		view.layer.cornerRadius = 30
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 19, left: 10, bottom: 19, right: 10)

		return view
	}()

	// MARK: - Internal properties
	var convertDateToDdMmYyyyHhMm: ((Date) -> (String))?
	var arrowBackButtonHandler: (() -> Void)?
	var goToChooseServicesButtonHandler: (() -> Void)?
	var saveButtonHandler: (() -> Void)?
    
    var onNameTextFieldValueChanged: ((String) -> ())?
    var onDateTextFieldValueChanged: ((String?) -> ())?
    var onPhoneNumberTextFieldValueChanged: ((String?) -> ())?

	// MARK: - Init
	init() {
		super.init(frame: .zero)
        addKeyboardDidmiss()

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Internal methods
	func setTextField(model: AppointmentModel){
		inputClientNameTextField.text = model.clientName
		inputClientPhoneTextField.text = model.clientPhone
        dateTimeAppointmentTextField.text = model.startDateTime

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		if let date = dateFormatter.date(from: model.startDateTime) {
			dateTimeAppointmentPicker.date = date
			onFromDateDoneButtonPressed()
		}
	}

	// MARK: - Private methods
	private func setDatePickerOnFromDate() {
		let toolbar = UIToolbar()
		toolbar.sizeToFit()

		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onFromDateDoneButtonPressed))
		doneButton.tintColor = R.color.vinous()

		toolbar.setItems([doneButton], animated: true)

		dateTimeAppointmentTextField.inputAccessoryView = toolbar
		dateTimeAppointmentTextField.inputView = dateTimeAppointmentPicker
	}
}

// MARK: - Setup extension
private extension EditAppointmentView {
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
		addSubview(goToChooseServicesButton)
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

        goToChooseServicesButton.snp.makeConstraints { make in
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
		goToChooseServicesButton.addTarget(self, action: #selector(goToChooseServicesButtonPressed), for: .touchUpInside)
		saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
		arrowBackButton.addTarget(self, action: #selector(arrowBackButtonPressed), for: .touchUpInside)
        
        inputClientNameTextField.addTarget(self, action: #selector(clientNameTextFieldDidChange(_:)), for: .editingChanged)
        dateTimeAppointmentTextField.addTarget(self, action: #selector(dateTimeTextFieldDidChange(_:)), for: .editingChanged)
        inputClientPhoneTextField.addTarget(self, action: #selector(clientPhoneNumberTextFieldDidChange(_:)), for: .editingChanged)
	}
}

// MARK: - Actions
private extension EditAppointmentView {
	@objc func onFromDateDoneButtonPressed() {
		dateTimeAppointmentTextField.text = (convertDateToDdMmYyyyHhMm ?? { _ in return "" })(dateTimeAppointmentPicker.date)
        onDateTextFieldValueChanged?((convertDateToDdMmYyyyHhMm ?? { _ in return "" })(dateTimeAppointmentPicker.date))
		endEditing(true)
	}

	@objc func arrowBackButtonPressed() {
		arrowBackButtonHandler?()
	}

	@objc func goToChooseServicesButtonPressed() {
        goToChooseServicesButtonHandler?()
	}

	@objc func saveButtonPressed() {
		saveButtonHandler?()
	}
    
    @objc func clientNameTextFieldDidChange(_ textField: UITextField) {
        onNameTextFieldValueChanged?(textField.text ?? "")
    }
    
    @objc func dateTimeTextFieldDidChange(_ textField: UITextField) {
        onDateTextFieldValueChanged?(textField.text)
    }
    
    @objc func clientPhoneNumberTextFieldDidChange(_ textField: UITextField) {
        onPhoneNumberTextFieldValueChanged?(textField.text)
    }
    
}
