//
//  DateLineStackView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import UIKit

protocol DateLineDelegate: AnyObject {
    var weekDates: [Date] { get set }
    var currentDayIndex: Int { get set }
    var selectedDayIndex: Int { get set }
    
    var onLeftArrowButtonClicked: (() -> ()) { get }
    var onRightArrowButtonClicked: (() -> ()) { get }
    var onDateViewClicked: ((Int) -> ()) { get }
    
    var getDayOfMonthByDate: ((Date) -> Int) { get }
    var getDayOfWeekByDate: ((Date, Int) -> String) { get }
    var getWeekdayIndex: ((Date) -> Int) { get }
    var isToday: ((Date) -> Bool) { get }
}

class DateLineStackView: UIStackView {

    weak var delegate: DateLineDelegate?
    
    private var dates: [DateView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .equalSpacing
        isUserInteractionEnabled = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDateLineStackView() {
        addArrangedSubview(leftArrowButton)
        for date in delegate?.weekDates ?? [] {
            let myDateView = createDateView(from: date)
            dates.append(myDateView)
            addArrangedSubview(myDateView)
            myDateView.snp.makeConstraints { make in
                make.width.equalTo(30)
            }
        }
        addArrangedSubview(rightArrowButton)
    }
    
    func configureAppearance() {
        setupDateLineStackView()
        updateDates()
    }
    
    private func createDateView(from date: Date) -> DateView {
        let myDateView = DateView(
            dayOfMonth: delegate?.getDayOfMonthByDate(date) ?? 1,
            dayOfWeek: delegate?.getDayOfWeekByDate(date, 2) ?? "Пн",
            isCurrentDay: delegate?.weekDates[delegate?.currentDayIndex ?? 1] == Date(),
            isSelectedDay: delegate?.currentDayIndex ?? 1 == delegate?.getWeekdayIndex(date) ?? 1,
            weekdayIndex: delegate?.getWeekdayIndex(date) ?? 1
        )
        let gestureRecognizer = MyTapGesture(target: self, action: #selector(onDateViewClicked(_:)))
        gestureRecognizer.weekdayIndex = myDateView.weekdayIndex
        myDateView.addGestureRecognizer(gestureRecognizer)
        return myDateView
    }
    @objc private func onDateViewClicked(_ sender: MyTapGesture) {
        delegate?.onDateViewClicked(sender.weekdayIndex)
        delegate?.selectedDayIndex = sender.weekdayIndex
        updateDates()
    }
    
    // MARK: - LeftArrowButton setup
    private lazy var leftArrowButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(R.image.backArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(onLeftArrowButtonClicked), for: .touchUpInside)
        return myButton
    }()
    @objc private func onLeftArrowButtonClicked() {
        delegate?.onLeftArrowButtonClicked()
        updateDates()
    }
    
    // MARK: - RightArrowButton setup
    private lazy var rightArrowButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(R.image.forwardArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(onRightArrowButtonClicked), for: .touchUpInside)
        return myButton
    }()
    @objc private func onRightArrowButtonClicked() {
        delegate?.onRightArrowButtonClicked()
        updateDates()
    }
    
    func updateDates() {
        DispatchQueue.main.async { [self] in
            for date in dates {
                date.isCurrentDay = (delegate?.isToday(delegate?.weekDates[date.weekdayIndex] ?? Date())) ?? false
                date.isSelectedDay = date.weekdayIndex == delegate?.selectedDayIndex ?? 1
                date.dayOfMonth = delegate?.getDayOfMonthByDate(delegate?.weekDates[date.weekdayIndex] ?? Date()) ?? 1
                date.dayOfWeek = delegate?.getDayOfWeekByDate(delegate?.weekDates[date.weekdayIndex] ?? Date(), 2) ?? "Пн"
                date.configureAppearance()
            }
        }
    }
    
}

final class MyTapGesture: UITapGestureRecognizer {
    var weekdayIndex = Int()
}
