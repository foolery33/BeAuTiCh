//
//  MainViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import UIKit

final class ScheduleViewController: UIViewController {

	private let viewModel: MainViewModel
    private let dayAppointments: [AppointmentModel]
    private var notes: [NoteView] = []
    
    var changeDateTimeStringToHhMm: ((String) -> (String))?
    
    init(dayAppointments: [AppointmentModel], viewModel: MainViewModel) {
		self.viewModel = viewModel
        self.dayAppointments = dayAppointments
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupScrollView()
    }
    
    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        view.addSubview(scrollView)
        setupContentStackView()
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
    
    // MARK: - ChillImageView setup
    private lazy var chillImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.chillImage()
        return myImageView
    }()
    private func setupChillImageView() {
        scrollView.addSubview(chillImageView)
        chillImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension ScheduleViewController {
    
    func setupNotes(dayAppointments: [AppointmentModel]) {
        // Удаление всех View из Left и Right StackView:
        notes = []
        for subview in leftStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        for subview in rightStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        // Удаление картинки-заглушки
        chillImageView.removeFromSuperview()
        
        if dayAppointments.count != 0 {
            for appointment in dayAppointments {
                createNote(appointment: appointment, customerName: appointment.clientName, serviceName: appointment.services.map { $0.name }, time: appointment.startDateTime, cost: appointment.price)
            }
      
            leftStackView.addArrangedSubview(createEmptyView())
            rightStackView.addArrangedSubview(createEmptyView())
        }
        else {
            setupChillImageView()
        }
        
    }
    
}

private extension ScheduleViewController {
    
    func createNote(appointment: AppointmentModel, customerName: String, serviceName: [String], time: String, cost: Double) {
        let newNote = NoteView(
            appointment: appointment,
            customerName: customerName,
            serviceName: serviceName,
            time: changeDateTimeStringToHhMm?(time) ?? time,
            cost: Int(cost)
        )
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

		newNote.viewPressedHandler = { [ weak self ] appointment in
			guard let self = self else { return }

            self.viewModel.goToDetailsMainScreen(appointment: appointment)
		}
    }
    
    func createEmptyView() -> UIView {
        let myView = UIView()
        return myView
    }
}

