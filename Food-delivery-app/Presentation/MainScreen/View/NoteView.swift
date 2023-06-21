//
//  NoteView.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import UIKit
import SnapKit

class NoteView: UIView {

    private let appointment: AppointmentModel
    private let customerName: String
    private let serviceName: [String]
    private let time: String
    private let cost: Int
    
    init(appointment: AppointmentModel, customerName: String, serviceName: [String], time: String, cost: Int) {
        self.appointment = appointment
        self.customerName = customerName
        self.serviceName = serviceName
        self.time = time
        self.cost = cost
        super.init(frame: .zero)
        setupNoteView()
        configureActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	var viewPressedHandler: ((AppointmentModel) -> Void)?

	private enum Metrics {
		static let a = 12
	}
    
    private func setupNoteView() {
		isUserInteractionEnabled = true
        backgroundColor = R.color.softWhite()
        layer.cornerRadius = 23
        layer.masksToBounds = true
        setupNoteInfoStackView()
    }

    // MARK: - NoteInfoStackView setup
    private lazy var noteInfoStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.spacing = 2
        myStackView.axis = .vertical
        return myStackView
    }()
    private func setupNoteInfoStackView() {
        addSubview(noteInfoStackView)
        setupCustomerNameLabel()
        setupServiceNameStackView()
        setupTimeAndCostStackView()
		setupCircleElementsImageViews()
        noteInfoStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(13)
            make.bottom.equalToSuperview().offset(-6)
        }
    }

	// MARK: - CircleElements setup
	private lazy var leftCircleElementImageView: UIImageView = {
		let view = UIImageView()
		view.image = R.image.rightCircleElement()

		return view
	}()
	private lazy var rightCircleElementImageView: UIImageView = {
		let view = UIImageView()
		view.image = R.image.leftCircleElement()

		return view
	}()
	private func setupCircleElementsImageViews() {
		addSubview(leftCircleElementImageView)
		addSubview(rightCircleElementImageView)

		leftCircleElementImageView.snp.makeConstraints { make in
			make.trailing.top.equalToSuperview()
		}

		rightCircleElementImageView.snp.makeConstraints { make in
			make.bottom.leading.equalToSuperview()
		}
	}
    
    // MARK: - CustomerNameLabel setup
    private lazy var customerNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = customerName
        myLabel.textColor = R.color.vinous()
        myLabel.font = R.font.redHatDisplaySemiBold(size: 14)
        myLabel.numberOfLines = 1
        return myLabel
    }()
    private func setupCustomerNameLabel() {
        noteInfoStackView.addArrangedSubview(customerNameLabel)
    }
    
    // MARK: - ServiceNamesStackView setup
    private lazy var serviceNamesStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 1
        return myStackView
    }()
    private func setupServiceNameStackView() {
        noteInfoStackView.addArrangedSubview(serviceNamesStackView)
        for name in serviceName {
            let currentServiceNameLabel = createServiceNameLabel(serviceName: name)
            serviceNamesStackView.addArrangedSubview(currentServiceNameLabel)
        }
    }
    
    private func createServiceNameLabel(serviceName: String) -> UILabel {
        let myLabel = UILabel()
        myLabel.text = serviceName
        myLabel.textColor = R.color.vinous()
        myLabel.font = R.font.redHatDisplayRegular(size: 11)
        myLabel.numberOfLines = 1
        return myLabel
    }
    
    // MARK: - TimeAndCostStackView setup
    private lazy var timeAndCostStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.distribution = .equalSpacing
        myStackView.axis = .horizontal
        return myStackView
    }()
    private func setupTimeAndCostStackView() {
        noteInfoStackView.setCustomSpacing(12, after: serviceNamesStackView)
        serviceNamesStackView.addArrangedSubview(timeAndCostStackView)
        setupTimeLabel()
        setupCostLabel()
    }
    
    // MARK: - TimeLabel setup
    private lazy var timeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = time
        myLabel.textColor = R.color.darkOrange()
        myLabel.font = R.font.redHatDisplayRegular(size: 10)
        return myLabel
    }()
    private func setupTimeLabel() {
        timeAndCostStackView.addArrangedSubview(timeLabel)
    }
    
    // MARK: - CostLabel setup
    private lazy var costLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "\(String(cost))р"
        myLabel.textColor = R.color.darkOrange()
        myLabel.font = R.font.redHatDisplayRegular(size: 10)
        return myLabel
    }()
    private func setupCostLabel() {
        timeAndCostStackView.addArrangedSubview(costLabel)
    }

	func configureActions() {
		self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
	}

	@objc
	private func viewTapped() {
		viewPressedHandler?(appointment)
	}
}
