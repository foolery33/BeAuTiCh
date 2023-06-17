//
//  FilterView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import UIKit

class FilterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
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
        setupSortingLabel()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
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
        myImageView.image = R.image.filterServiceArrow()
        myImageView.contentMode = .center
        return myImageView
    }()
    private func setupFilterServiceArrowImage() {
        chooseFilterServicesStackView.addArrangedSubview(filterServiceArrowImage)
    }

    // MARK: - SortingLabel setup
    private lazy var sortingLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.filterScreen.sorting()
        myLabel.font = R.font.redHatDisplayBlack(size: 30)
        myLabel.textColor = R.color.white()
        return myLabel
    }()
    private func setupSortingLabel() {
        contentView.addSubview(sortingLabel)
        sortingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(chooseFilterServicesStackView.snp.bottom).offset(30)
        }
    }
    
    // MARK: - 
    
}
