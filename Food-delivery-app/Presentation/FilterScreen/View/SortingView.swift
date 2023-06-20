//
//  SortingView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 18.06.2023.
//

import UIKit

enum SortingCriteria {
    case price
    case date
}

final class SortingView: UIView {

    private let headerText: String
    private let sortingCriteria: SortingCriteria
    var onFromTextFieldValueChanged: ((String) -> ())?
    var onToTextFieldValueChanged: ((String) -> ())?
    
    var fromTextFieldText: String?
    var toTextFieldText: String?
    
    var convertDateToDdMmYyyy: ((Date) -> (String))?
    
    init(headerText: String, sortingCriteria: SortingCriteria) {
        self.headerText = headerText
        self.sortingCriteria = sortingCriteria
        super.init(frame: .zero)
        setupSubviews()
        setupTextFieldHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupSortLabel()
        setupSortStackView()
    }
    
    // MARK: - SortLabel setup
    private lazy var sortLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = headerText
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.redHatDisplayMedium(size: 18)
        return myLabel
    }()
    private func setupSortLabel() {
        addSubview(sortLabel)
        sortLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    // MARK: - SortStackView setup
    private lazy var sortStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 17
        return myStackView
    }()
    private func setupSortStackView() {
        addSubview(sortStackView)
        setupFromStackView()
        setupToStackView()
        sortStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.trailing.equalToSuperview()
            make.top.equalTo(sortLabel.snp.bottom).offset(9)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - FromStackView setup
    private lazy var fromStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.spacing = 5
        myStackView.axis = .horizontal
        return myStackView
    }()
    private func setupFromStackView() {
        sortStackView.addArrangedSubview(fromStackView)
        setupFromLabel()
        setupFromTextField()
    }
    
    // MARK: - FromLabel setup
    private lazy var fromLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.filterScreen.from()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.redHatDisplayRegular(size: 15)
        return myLabel
    }()
    private func setupFromLabel() {
        fromStackView.addArrangedSubview(fromLabel)
        fromLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
    
    // MARK: - FromTextField setup
    private lazy var fromTextField: CustomUITextField = {
        let myTextField = CustomUITextField(isSecured: false, currentText: fromTextFieldText ?? "", placeholderText: R.string.filterScreen.enter_price(), isSmallVersion: true)
        return myTextField
    }()
    private func setupFromTextField() {
        fromStackView.addArrangedSubview(fromTextField)
    }
    
    // MARK: - ToStackView setup
    private lazy var toStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.spacing = 5
        myStackView.axis = .horizontal
        return myStackView
    }()
    private func setupToStackView() {
        sortStackView.addArrangedSubview(toStackView)
        setupToLabel()
        setupToTextField()
    }
    
    // MARK: - ToLabel setup
    private lazy var toLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.filterScreen.to()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.redHatDisplayRegular(size: 15)
        return myLabel
    }()
    private func setupToLabel() {
        toStackView.addArrangedSubview(toLabel)
        toLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
    
    // MARK: - ToTextField setup
    private lazy var toTextField: CustomUITextField = {
        let myTextField = CustomUITextField(isSecured: false, currentText: toTextFieldText ?? "", placeholderText: R.string.filterScreen.enter_price(), isSmallVersion: true)
        return myTextField
    }()
    private func setupToTextField() {
        toStackView.addArrangedSubview(toTextField)
    }
    
    // MARK: - FromDatePicker setup
    private lazy var fromDatePicker: UIDatePicker = {
        let myDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.maximumDate = Date()
        return myDatePicker
    }()
    
    // MARK: - ToDatePicker setup
    private lazy var toDatePicker: UIDatePicker = {
        let myDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.maximumDate = Date()
        return myDatePicker
    }()
    
    private func setupTextFieldHandlers() {
        switch sortingCriteria {
        case .price:
            fromTextField.addTarget(self, action: #selector(onFromPriceValueChanged(_:)), for: .editingChanged)
            toTextField.addTarget(self, action: #selector(onToPriceValueChanged(_:)), for: .editingChanged)
        case .date:
            fromTextField.addTarget(self, action: #selector(onFromDateValueChanged(_:)), for: .editingChanged)
            toTextField.addTarget(self, action: #selector(onToDateValueChanged(_:)), for: .editingChanged)
            setDatePickerOnFromDate()
            setDatePickerOnToDate()
        }
    }
    
    func setTextToTextFields() {
        fromTextField.text = fromTextFieldText ?? ""
        toTextField.text = toTextFieldText ?? ""
    }

}

private extension SortingView {
    @objc func onFromPriceValueChanged(_ textField: UITextField) {
        let numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for character in textField.text ?? "" {
            if numbers.contains(character) == false {
                textField.text = String(textField.text?.prefix((textField.text?.count ?? 1) - 1) ?? "")
            }
        }
        (onFromTextFieldValueChanged ?? { _ in })(textField.text ?? "")
    }
    
    @objc private func onToPriceValueChanged(_ textField: UITextField) {
        let numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for character in textField.text ?? "" {
            if numbers.contains(character) == false {
                textField.text = String(textField.text?.prefix((textField.text?.count ?? 1) - 1) ?? "")
            }
        }
        (onToTextFieldValueChanged ?? { _ in })(textField.text ?? "")
    }
    
    func setDatePickerOnFromDate() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onFromDateDoneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        
        fromTextField.inputAccessoryView = toolbar
        fromTextField.inputView = fromDatePicker
    }
    @objc func onFromDateDoneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        fromTextField.text = dateFormatter.string(from: fromDatePicker.date)
        (onFromTextFieldValueChanged ?? { _ in })("\((convertDateToDdMmYyyy ?? { _ in return "" })(fromDatePicker.date))")
        endEditing(true)
    }
    @objc private func onFromDateValueChanged(_ textField: UITextField) {
        (onFromTextFieldValueChanged ?? { _ in })(textField.text ?? "")
    }
    
    func setDatePickerOnToDate() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onToDateDoneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        
        toTextField.inputAccessoryView = toolbar
        toTextField.inputView = toDatePicker
    }
    @objc func onToDateDoneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        toTextField.text = dateFormatter.string(from: toDatePicker.date)
        (onToTextFieldValueChanged ?? { _ in })("\((convertDateToDdMmYyyy ?? { _ in return "" })(toDatePicker.date))")
        endEditing(true)
    }
    @objc private func onToDateValueChanged(_ textField: UITextField) {
        (onToTextFieldValueChanged ?? { _ in })(textField.text ?? "")
    }
}
