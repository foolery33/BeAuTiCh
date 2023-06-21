//
//  SettingsViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

final class SettingsViewModel {
    weak var coordinator: SettingsCoordinator?

	var subscribe = Observable<SubscribeModel>()
	var errorMessage = Observable<String>()

	private var subscribeRepository: SubscribeRepository?

	init(subscribeRepository: SubscribeRepository?) {
		self.subscribeRepository = subscribeRepository
	}

	func goToInformationSubcribeScreen(delegate: SheetViewControllerDelegate) {
        coordinator?.goToInformationSubcribeScreen(delegate: delegate)
    }
    
    func goToServicesScreen(delegate: SheetViewControllerDelegate) {
        coordinator?.goToServicesScreen(delegate: delegate)
    }

	func isThereSubscription() async -> Bool? {
		do {
			let check = try await subscribeRepository?.isThereSubscription()

			if check ?? false {
				await fetchInformationSubscribe()
			}

			return check ?? false
		} catch(let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)
			}
			else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}

			return nil
		}
	}

	func fetchInformationSubscribe() async {
		do {
			let subscribe = try await subscribeRepository?.fetchInformationSubscribe() ?? SubscribeModel(createDate: String())

			self.subscribe.updateModel(with: subscribe)
		} catch(let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)
			}
			else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}

		}
	}

	func cancelSubscribe() async -> Bool {
		do {
			_ = try await subscribeRepository?.changeStatusSubscribe(status: false)

			return true

		} catch(let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)
			}
			else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}
			return false
		}
	}

	func subscribe() async -> Bool {
		do {
			_ = try await subscribeRepository?.changeStatusSubscribe(status: true)

			return true

		} catch(let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)
			}
			else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}

			return false
		}
	}
}
