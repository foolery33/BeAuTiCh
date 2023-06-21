//
//  ScheduleSetupViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 09.06.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
//        getTimezoneAppointments()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		getTimezoneAppointments()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTimezoneAppointments()
    }
    
    private func setupSubviews() {
        setupContentView()
        setupPageViewController()
    }
    
    // MARK: - ContentView setup
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        view.addSubview(contentView)
        setupBackgroundImage()
        addHeaderButtons()
        setupDateLineStackView()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupPageViewController() {
        addChild(pageViewController)
        setSwipeAction()
        view.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(addNoteButton.snp.bottom).offset(22)
            make.bottom.equalTo(dateLineStackView.snp.top)
        }
        pageViewController.didMove(toParent: self)
    }
    
    private lazy var pageViewController: MainPageViewController = {
        let myMainPageViewController = MainPageViewController(viewModel: viewModel)
        return myMainPageViewController
    }()
    
    // MARK: - BackgroundImage setup
    private lazy var backgroundImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.background2()
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private func setupBackgroundImage() {
        contentView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addHeaderButtons() {
        setupAddNoteButton()
    }
    
    // MARK: - AddNoteButton setup
    private lazy var addNoteButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(R.image.plusNote(), for: .normal)
        return myButton
    }()
    private func setupAddNoteButton() {
        contentView.addSubview(addNoteButton)
        addNoteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
    }
    
    
    // MARK: - DateLineStackView setup
    private lazy var dateLineStackView: DateLineStackView = {
        let myStackView = DateLineStackView()
        myStackView.delegate = self
        myStackView.configureAppearance()
        return myStackView
    }()
    private func setupDateLineStackView() {
        contentView.addSubview(dateLineStackView)
        dateLineStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            make.horizontalEdges.equalToSuperview().inset(17)
        }
    }
}

// MARK: - DateLineDelegate
extension MainViewController: DateLineDelegate {
    var weekDates: [Date] {
        get {
            viewModel.weekDates
        }
        set {
            viewModel.weekDates = newValue
        }
    }
    
    var currentDayIndex: Int {
        get {
            viewModel.currentDayIndex
        }
        set {
            viewModel.currentDayIndex = newValue
        }
    }
    
    var selectedDayIndex: Int {
        get {
            viewModel.selectedDayIndex
        }
        set {
            viewModel.selectedDayIndex = newValue
        }
    }
    
    var onLeftArrowButtonClicked: (() -> ()) {
        viewModel.onLeftArrowButtonClicked
    }
    
    var onRightArrowButtonClicked: (() -> ()) {
        viewModel.onRightArrowButtonClicked
    }
    
    var onDateViewClicked: ((Int) -> ()) {
        return { index in
            self.pageViewController.setViewControllers([self.pageViewController.pages[index]], direction: self.viewModel.selectedDayIndex > index ? .reverse : .forward, animated: true, completion: nil)
        }
    }
    
    var getDayOfMonthByDate: ((Date) -> Int) {
        viewModel.getDayOfMonthByDate(_:)
    }
    
    var getDayOfWeekByDate: ((Date, Int) -> String) {
        viewModel.getDayOfWeekByDate(_:lettersCount:)
    }
    
    var getWeekdayIndex: ((Date) -> Int) {
        viewModel.getWeekdayIndexForDate(_:)
    }
    
    var isToday: ((Date) -> Bool) {
        viewModel.isToday(_:)
    }
}

extension MainViewController {
    func setSwipeAction() {
        pageViewController.onSwipeAction = { [weak self] in
            self?.dateLineStackView.updateDates()
        }
    }
}

private extension MainViewController {
    func getTimezoneAppointments() {
		self.view.setupActivityIndicator(withBackground: false)

        Task {
            if await viewModel.getTimezoneAppointments() {
//                setupPageViewController()
                pageViewController.updatePages()
            }
            else {
                showAlert(title: R.string.errors.appointments_loading_error(), message: viewModel.error)
            }

			self.view.stopActivityIndicator()
        }
    }
}
