//
//  SettingsViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import Foundation

final class SettingsViewModel {
    weak var coordinator: SettingsCoordinator?

	var subscribe = Observable<SubscribeModel>()
	var customServices = Observable<[ServiceModel]>()
	var errorMessage = Observable<String>()

	private var subscribeRepository: SubscribeRepository?
	private let servicesRepository: ServicesRepository?
	private let convertStringToDateDdMmYyyyUseCase: ConvertStringToDateDdMmYyyyUseCase?

	init(subscribeRepository: SubscribeRepository?, convertStringToDateDdMmYyyyUseCase: ConvertStringToDateDdMmYyyyUseCase?, servicesRepository: ServicesRepository?) {
		self.subscribeRepository = subscribeRepository
		self.convertStringToDateDdMmYyyyUseCase = convertStringToDateDdMmYyyyUseCase
		self.servicesRepository = servicesRepository
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

	func convertDateToDdMmYyyy(_ date: String) -> String {
		return convertStringToDateDdMmYyyyUseCase?.convert(date) ?? date
	}

	func fetchCustomServices() async {
		do {
			let services = try await servicesRepository?.getCustomServices() ?? []
			customServices.updateModel(with: services)

		} catch(let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)
			}
			else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}
		}
	}

	func createNewService(model: CreateService) async -> Bool {
		do {
			_ = try await servicesRepository?.createCustomService(parameters: model)
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

	func editService(serviceId: UUID, model: EditService) async {

	}

	func deleteDervice(serviceId: UUID) async -> Bool {
		do {
			_ = try await servicesRepository?.deleteCustomService(serviceId: serviceId)
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
