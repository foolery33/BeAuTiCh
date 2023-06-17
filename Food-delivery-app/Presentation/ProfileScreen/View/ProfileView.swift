//
//  ProfileView.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import UIKit
import SnapKit

class ProfileView: UIView {

	// MARK: - Private properties

	private enum Metrics {

	}

	private lazy var backgroundImage: UIImageView = {
		let view = UIImageView()
		view.image = R.image.firstBackground()
		view.contentMode = .scaleAspectFill
		return view
	}()

	private lazy var signOutButton: UIButton = {
		let view = UIButton()
		view.setTitle(R.string.profileScreen.sign_out(), for: .normal)
		view.setTitleColor(R.color.white(), for: .normal)
		view.titleLabel?.textAlignment = .right
		view.titleLabel?.font = R.font.redHatDisplaySemiBold(size: 15)

		return view
	}()

	private lazy var changeAvatarButton: UIButton = {
		let view = UIButton()
		view.setTitle(R.string.profileScreen.change_photo(), for: .normal)
		view.setTitleColor(R.color.white(), for: .normal)
		view.titleLabel?.textAlignment = .right
		view.titleLabel?.font = R.font.redHatDisplayMedium(size: 15)

		return view
	}()

	private lazy var deleteAvatarButton: UIButton = {
		let view = UIButton()
		view.setTitle(R.string.profileScreen.delete_photo(), for: .normal)
		view.setTitleColor(R.color.white(), for: .normal)
		view.titleLabel?.textAlignment = .right
		view.titleLabel?.font = R.font.redHatDisplayMedium(size: 15)

		return view
	}()

	private lazy var avatarImageView: UIImageView = {
		let view = UIImageView()
		view.image = R.image.defaultAvatar()
		view.contentMode = .scaleAspectFit

		return view
	}()

	private lazy var nameLabel: UILabel = {
		let view = UILabel()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayBlack(size: 30)

		return view
	}()

	private lazy var informationStack: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.spacing = 15

		return view
	}()

	private lazy var phoneLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.profileScreen.phone()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var emailLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.profileScreen.email()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var buttonsStack: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.spacing = 27

		return view
	}()

	private lazy var changeDataProfileButton: UIButton = {
		let view = UIButton()
		view.setTitle(R.string.profileScreen.change_data(), for: .normal)
		view.setTitleColor(R.color.vinous(), for: .normal)
		view.titleLabel?.textAlignment = .center
		view.titleLabel?.font = R.font.ralewayBold(size: 17)
		view.titleLabel?.numberOfLines = .max
		view.backgroundColor = .white
		view.layer.cornerRadius = 20
		view.layer.masksToBounds = true
		view.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)


		return view
	}()

	private lazy var changePasswordButton: UIButton = {
		let view = UIButton()
		view.setTitle(R.string.profileScreen.change_password(), for: .normal)
		view.setTitleColor(R.color.white(), for: .normal)
		view.titleLabel?.textAlignment = .center
		view.titleLabel?.font = R.font.ralewayRegular(size: 17)

		return view
	}()


	// MARK: - Public properties


	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Public methods
}


// MARK: - Private extensions

private extension ProfileView {

	// MARK: - Setup

	func setup() {
		configureUI()
		configureConstraints()
		configureActions()
	}

	func configureUI() {
		self.addSubview(backgroundImage)
		self.addSubview(signOutButton)
		self.addSubview(avatarImageView)
		self.addSubview(nameLabel)
		self.addSubview(informationStack)
		self.addSubview(buttonsStack)

		informationStack.addArrangedSubview(phoneLabel)
		informationStack.addArrangedSubview(emailLabel)

		avatarImageView.addSubview(changeAvatarButton)
		avatarImageView.addSubview(deleteAvatarButton)

		buttonsStack.addArrangedSubview(changeDataProfileButton)
		buttonsStack.addArrangedSubview(changePasswordButton)
	}

	func configureConstraints() {
		backgroundImage.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		signOutButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(15)
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
		}

		avatarImageView.snp.makeConstraints { make in
			make.top.horizontalEdges.equalToSuperview()
		}

		changeAvatarButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(6)
			make.bottom.equalToSuperview().offset(16)
		}

		deleteAvatarButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(6)
			make.bottom.equalToSuperview().offset(16)
		}

		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(avatarImageView.snp.bottom).offset(15)
			make.horizontalEdges.equalToSuperview().inset(20)
		}

		informationStack.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(35)
			make.horizontalEdges.equalToSuperview().inset(28)
		}

		buttonsStack.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(75)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(42)
		}
	}

	func configureActions() {

	}
}
