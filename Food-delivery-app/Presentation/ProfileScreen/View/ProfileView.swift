//
//  ProfileView.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

class ProfileView: UIView {

	// MARK: - Private properties

	private enum Metrics {
		static let gradientStartPoint = CGPoint(x: 0, y: 0.65)
		static let gradientEndPoint = CGPoint(x: 0, y: 1)
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

	lazy var avatarImageView: UIImageView = {
		let view = UIImageView()
		view.image = R.image.defaultAvatar()
		view.contentMode = .scaleToFill
		view.isSkeletonable = true

		return view
	}()

	private lazy var nameLabel: UILabel = {
		let view = UILabel()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.font = R.font.redHatDisplayBlack(size: 30)
		view.isSkeletonable = true
		view.skeletonTextNumberOfLines = 3

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
		view.isSkeletonable = true
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var emailLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.profileScreen.email()
		view.textColor = R.color.white()
		view.textAlignment = .left
		view.isSkeletonable = true
		view.font = R.font.redHatDisplayMedium(size: 18)

		return view
	}()

	private lazy var buttonsStack: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.spacing = 15

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

	lazy var gradient: CAGradientLayer = {
		let myGradient = CAGradientLayer()
		myGradient.colors = [UIColor.clear.cgColor, R.color.softBrown()?.cgColor ?? UIColor.black.cgColor]
		myGradient.startPoint = Metrics.gradientStartPoint
		myGradient.endPoint = Metrics.gradientEndPoint
		return myGradient
	}()


	// MARK: - Internal properties

	var signOutButtonHandler: (() -> Void)?
	var deleteAvatarButtonHandler: (() -> Void)?
	var changeAvatarButtonHandler: (() -> Void)?
	var changeDataProfileButtonHandler: (() -> Void)?
	var changePasswordButtonHandler: (() -> Void)?


	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		gradient.frame = avatarImageView.bounds
		avatarImageView.layer.addSublayer(gradient)
	}


	// MARK: - Internal methods

	func setDataProfile(profile: ProfileModel) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.stopSkeleton()

			self.nameLabel.hideSkeleton()
			self.nameLabel.text = profile.fullName
			if let phone = profile.phoneNumber {
				self.phoneLabel.text = "\(R.string.profileScreen.phone()) \(phone)"
			}
			self.emailLabel.text = "\(R.string.profileScreen.email()) \(profile.email)"
		}
	}

	func getFullname() -> String {
		return nameLabel.text ?? String()
	}

	func getPhone() -> String? {
		if let range = phoneLabel.text?.range(of: "\(R.string.profileScreen.phone()) ") {
			let testString2 = phoneLabel.text?.replacingCharacters(in: range,
															 with: "")
			return testString2
		}

		return nil
	}

	func setAvatar(avatar: UIImage) {
		avatarImageView.image = avatar

	}

	func startSkeleton() {
		nameLabel.showAnimatedSkeleton(usingColor: UIColor.gray)
		phoneLabel.showAnimatedSkeleton(usingColor: UIColor.gray)
		emailLabel.showAnimatedSkeleton(usingColor: UIColor.gray)
	}

	private func stopSkeleton() {
		nameLabel.hideSkeleton()
		phoneLabel.hideSkeleton()
		emailLabel.hideSkeleton()
	}
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
		self.addSubview(avatarImageView)
		self.addSubview(signOutButton)
		self.addSubview(nameLabel)
		self.addSubview(informationStack)
		self.addSubview(buttonsStack)
		self.addSubview(changeAvatarButton)
		self.addSubview(deleteAvatarButton)

		informationStack.addArrangedSubview(phoneLabel)
		informationStack.addArrangedSubview(emailLabel)

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
			make.height.equalTo(193)
		}

		changeAvatarButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(10)
			make.bottom.equalTo(avatarImageView.snp.bottom).inset(10)
		}

		deleteAvatarButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(10)
			make.bottom.equalTo(avatarImageView.snp.bottom).inset(10)
		}

		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(avatarImageView.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(28)
		}

		informationStack.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(28)
		}

		buttonsStack.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(75)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(42)
		}
	}

	func configureActions() {
		signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
		changeAvatarButton.addTarget(self, action: #selector(changeAvatarButtonPressed), for: .touchUpInside)
		deleteAvatarButton.addTarget(self, action: #selector(deleteAvatarButtonPressed), for: .touchUpInside)
		changeDataProfileButton.addTarget(self, action: #selector(changeDataProfileButtonPressed), for: .touchUpInside)
		changePasswordButton.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
	}


	// MARK: - Actions

	@objc
	func signOutButtonPressed() {
		signOutButtonHandler?()
	}

	@objc
	func changeAvatarButtonPressed() {
		changeAvatarButtonHandler?()
	}

	@objc
	func deleteAvatarButtonPressed() {
		deleteAvatarButtonHandler?()
	}

	@objc
	func changeDataProfileButtonPressed() {
		changeDataProfileButtonHandler?()
	}

	@objc
	func changePasswordButtonPressed() {
		changePasswordButtonHandler?()
	}

}
