//
//  MainViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import UIKit

final class ScheduleViewController: UIViewController {

	private let viewModel: MainViewModel
    private let serviceNotes: [NoteModel]
    private var notes: [NoteView] = []
    
    init(serviceNotes: [NoteModel], viewModel: MainViewModel) {
		self.viewModel = viewModel
        self.serviceNotes = serviceNotes
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupScrollView()
        setupNotes()
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

private extension ScheduleViewController {
    
    func setupNotes() {
        for serviceNote in serviceNotes {
            createNote(customerName: serviceNote.customerName, serviceName: serviceNote.serviceName, time: serviceNote.time, cost: serviceNote.cost)
        }
  
        leftStackView.addArrangedSubview(createEmptyView())
        rightStackView.addArrangedSubview(createEmptyView())
    }
    
    func createNote(customerName: String, serviceName: [String], time: String, cost: Int) {
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

		newNote.viewPressedHandler = { [ weak self ] in
			guard let self = self else { return }

			self.viewModel.goToDetailsMainScreen()
		}
    }
    
    func createEmptyView() -> UIView {
        let myView = UIView()
        return myView
    }
}

