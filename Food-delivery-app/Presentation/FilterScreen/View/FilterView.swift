//
//  FilterView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import UIKit

final class FilterView: UIView {

    var onPriceFromTextFieldValueChanged: ((String) -> ())?
    var onPriceToTextFieldValueChanged: ((String) -> ())?
    var onDateFromTextFieldValueChanged: ((String) -> ())?
    var onDateToTextFieldValueChanged: ((String) -> ())?
    
    var onSaveButtonTapped: (() -> ())?
    
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
    
    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        addSubview(scrollView)
        setupContentView()
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ContentView setup
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupChooseFilterServicesStackView()
        setupPriceSortingView()
        setupDateSortingView()
        setupSaveButton()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }
    }
    
    // MARK: - ChooseFilterServicesStackView setup
    private lazy var chooseFilterServicesStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 20
        return myStackView
    }()
    private func setupChooseFilterServicesStackView() {
        contentView.addSubview(chooseFilterServicesStackView)
        setupChooseFilterServicesLabel()
        setupFilterServiceArrowImage()
        chooseFilterServicesStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(21)
            make.top.equalToSuperview().inset(21)
        }
    }
    
    // MARK: - ChooseFilterServicesLabel setup
    private lazy var chooseFilterServicesLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.filterScreen.choose_services_for_filtration()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.redHatDisplayMedium(size: 18)
        myLabel.numberOfLines = 1
        return myLabel
    }()
    private func setupChooseFilterServicesLabel() {
        chooseFilterServicesStackView.addArrangedSubview(chooseFilterServicesLabel)
    }
    
    // MARK: - FilterServiceArrowImage setup
    private lazy var filterServiceArrowImage: UIImageView = {
        let myImageView = UIImageView()
		// TODO: - Изменить картинку
        myImageView.image = R.image.arrow()
        myImageView.contentMode = .center
        return myImageView
    }()
    private func setupFilterServiceArrowImage() {
        chooseFilterServicesStackView.addArrangedSubview(filterServiceArrowImage)
    }

    // MARK: - PriceSortingView setup
    private lazy var priceSortingView: SortingView = {
        let mySortingView = SortingView(headerText: R.string.filterScreen.by_price(), sortingCriteria: .price)
        return mySortingView
    }()
    private func setupPriceSortingView() {
        contentView.addSubview(priceSortingView)
        priceSortingView.snp.makeConstraints { make in
            make.top.equalTo(chooseFilterServicesStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(28)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width / 2.25)
        }
    }

    // MARK: - DateSortingView setup
    private lazy var dateSortingView: SortingView = {
        let mySortingView = SortingView(headerText: R.string.filterScreen.by_date(), sortingCriteria: .date)
        return mySortingView
    }()
    private func setupDateSortingView() {
        contentView.addSubview(dateSortingView)
        dateSortingView.snp.makeConstraints { make in
            make.top.equalTo(priceSortingView.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(28)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width / 2.25)
        }
    }
    
    // MARK: - SaveButton setup
    private lazy var saveButton: FilledButton = {
        let myFilledButton = FilledButton(labelText: R.string.filterScreen.save())
        myFilledButton.isUserInteractionEnabled = true
        myFilledButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        return myFilledButton
    }()
    private func setupSaveButton() {
        contentView.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(dateSortingView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-30 - (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
            make.horizontalEdges.equalToSuperview().inset(47)
        }
    }
    @objc private func setButtonAction(_ sender: UIButton) {
        (onSaveButtonTapped ?? {})()
    }
    
}

extension FilterView {
    func setActionHandlers() {
        priceSortingView.onFromTextFieldValueChanged = { [weak self] text in
            (self?.onPriceFromTextFieldValueChanged ?? { _ in })(text)
        }
        priceSortingView.onToTextFieldValueChanged = { [weak self] text in
            (self?.onPriceToTextFieldValueChanged ?? { _ in })(text)
        }
        
        dateSortingView.onFromTextFieldValueChanged = { [weak self] text in
            (self?.onDateFromTextFieldValueChanged ?? { _ in })(text)
        }
        dateSortingView.onToTextFieldValueChanged = { [weak self] text in
            (self?.onDateToTextFieldValueChanged ?? { _ in })(text)
        }
    }
}
