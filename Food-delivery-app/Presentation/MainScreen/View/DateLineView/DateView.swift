//
//  DateView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import UIKit

class DateView: UIView {

    var dayOfMonth: Int
    var dayOfWeek: String
    var isCurrentDay: Bool
    var isSelectedDay: Bool
    private(set) var weekdayIndex: Int
    
    init(dayOfMonth: Int, dayOfWeek: String, isCurrentDay: Bool, isSelectedDay: Bool, weekdayIndex: Int) {
        self.dayOfMonth = dayOfMonth
        self.dayOfWeek = dayOfWeek
        self.isCurrentDay = isCurrentDay
        self.isSelectedDay = isSelectedDay
        self.weekdayIndex = weekdayIndex
        super.init(frame: .zero)
        setupSubviews()
        layer.cornerRadius = 2.5
        layer.masksToBounds = true
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAppearance() {
        if isSelectedDay {
            backgroundColor = R.color.white()
            dayOfMonthLabel.textColor = R.color.black()
            dayOfWeekLabel.textColor = R.color.black()
            transform = CGAffineTransformMakeScale(1.3, 1.3)
        }
        else {
            transform = .identity
        }
        if isCurrentDay {
            backgroundColor = R.color.white()
            dayOfMonthLabel.textColor = R.color.brightRed()
            dayOfWeekLabel.textColor = R.color.black()
        }
        if !isSelectedDay && !isCurrentDay {
            backgroundColor = R.color.white()?.withAlphaComponent(0.001)
            dayOfMonthLabel.textColor = R.color.softWhite()
            dayOfWeekLabel.textColor = R.color.white()?.withAlphaComponent(0.75)
        }
        dayOfMonthLabel.text = String(dayOfMonth)
        dayOfWeekLabel.text = dayOfWeek
    }
    
    private func setupSubviews() {
        setupDateInfoStackView()
    }
    
    // MARK: - DateInfoStackView setup
    private lazy var dateInfoStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 3
        myStackView.alignment = .center
        return myStackView
    }()
    private func setupDateInfoStackView() {
        addSubview(dateInfoStackView)
        setupDayOfMonthLabel()
        setupDayOfWeekLabel()
        dateInfoStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(2.5)
        }
    }
    
    // MARK: - DayOfMonthLabel setup
    private lazy var dayOfMonthLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = String(dayOfMonth)
        myLabel.font = R.font.redHatDisplayRegular(size: 11)
        return myLabel
    }()
    private func setupDayOfMonthLabel() {
        dateInfoStackView.addArrangedSubview(dayOfMonthLabel)
    }

    // MARK: - DayOfWeekLabel setup
    private lazy var dayOfWeekLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = dayOfWeek
        myLabel.font = R.font.redHatDisplayRegular(size: 7)
        return myLabel
    }()
    private func setupDayOfWeekLabel() {
        dateInfoStackView.addArrangedSubview(dayOfWeekLabel)
    }
    
}
