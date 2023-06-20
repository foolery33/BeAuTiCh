//
//  SearchView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit

class SearchView: UIView {
    
    var onTextFieldValueChange: ((String) -> ())?
    var convertTime: ((String) -> (String))?
    var getFilteredAppointmentList: (([AppointmentModel], String) -> ([AppointmentModel]))?
    var onFilterButtonTapped: (() -> ())?
    var appointmentList: [AppointmentModel]?
    
    var notes: [NoteView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addKeyboardDidmiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupBackgroundImage()
        setupFilterButton()
        setupSearchTextField()
        setupScrollView()
    }
    
    // MARK: - BackgroundImage setup
    private lazy var backgroundImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.background2()
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private func setupBackgroundImage() {
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - FilterButton setup
    private lazy var filterButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(R.image.filter(), for: .normal)
        myButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        myButton.addTarget(self, action: #selector(pressFilterButoon), for: .touchUpInside)
        return myButton
    }()
    private func setupFilterButton() {
        addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(21)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
    @objc private func pressFilterButoon() {
        (onFilterButtonTapped ?? {})()
    }
    
    // MARK: - SearchTextField setup
    private lazy var searchTextField: CustomUITextField = {
        let myTextField = CustomUITextField(isSecured: false, currentText: "", placeholderText: R.string.searchScreen.enter_client_name())
        myTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return myTextField
    }()
    private func setupSearchTextField() {
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(filterButton.snp.trailing).offset(19)
            make.trailing.equalToSuperview().inset(19)
            make.centerY.equalTo(filterButton)
        }
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        (onTextFieldValueChange ?? { _ in })(textField.text ?? "")
        if textField.text?.isEmpty ?? true {
            updateAppointmentsStackView(currentAppointments: appointmentList ?? [])
        }
        else {
            updateAppointmentsStackView(currentAppointments: (getFilteredAppointmentList ?? { _, _ in return [] })(appointmentList ?? [], textField.text ?? ""))
        }
    }
    
    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        addSubview(scrollView)
        setupContentStackView()
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(40)
            make.bottom.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ContentStackView setup
    private lazy var contentStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 28
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 27, bottom: 0, right: 27)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupContentStackView() {
        scrollView.addSubview(contentStackView)
        setupLeftStackView()
        setupRightStackView()
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - LeftStackView setup
    private lazy var leftStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 15
        return myStackView
    }()
    private func setupLeftStackView() {
        contentStackView.addArrangedSubview(leftStackView)
    }
    
    // MARK: - RightStackView setup
    private lazy var rightStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 15
        return myStackView
    }()
    private func setupRightStackView() {
        contentStackView.addArrangedSubview(rightStackView)
    }
    
}

extension SearchView {
    
    func setupNotes() {
        for serviceNote in appointmentList ?? [] {
            createNote(
                customerName: serviceNote.clientName,
                serviceName: serviceNote.services.map { $0.name },
                time: (convertTime ?? { _ in return "" })(serviceNote.startDateTime),
                cost: Int(serviceNote.price)
            )
        }
  
        leftStackView.addArrangedSubview(createEmptyView())
        rightStackView.addArrangedSubview(createEmptyView())
    }
    
    private func createNote(customerName: String, serviceName: [String], time: String, cost: Int) {
        let newNote = NoteView(customerName: customerName, serviceName: serviceName, time: time, cost: cost)
        notes.append(newNote)
        if notes.count % 2 == 1 {
            leftStackView.addArrangedSubview(newNote)
        }
        else {
            rightStackView.addArrangedSubview(newNote)
        }
        newNote.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 27 - 14)
        }
    }
    
    private func createEmptyView() -> UIView {
        let myView = UIView()
        return myView
    }
    
    func updateAppointmentsStackView(currentAppointments: [AppointmentModel]) {
        print(currentAppointments.count)
        print(leftStackView)
//        print(leftStackView.arrangedSubviews.count)
//        print(rightStackView.arrangedSubviews.count)
//        print(notes)
//
        for subview in leftStackView.arrangedSubviews  {
            subview.removeFromSuperview()
        }
        for subview in rightStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        // Удаление существующих записей
        notes = []
        // Добавление в список отфильтрованных записей
        for appointment in currentAppointments {
            createNote(
                customerName: appointment.clientName,
                serviceName: appointment.services.map { $0.name },
                time: (convertTime ?? { _ in return "" })(appointment.startDateTime),
                cost: Int(appointment.price)
            )
        }
        leftStackView.addArrangedSubview(createEmptyView())
        rightStackView.addArrangedSubview(createEmptyView())
        
//        print(leftStackView.arrangedSubviews.count)
//        print(rightStackView.arrangedSubviews.count)
    }
    
}
