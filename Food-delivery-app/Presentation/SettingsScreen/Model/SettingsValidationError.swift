//
//  ValidationError.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

enum SettingsValidationError: String, Error {
	case emptyFieldNameService = "Поле с именем сервиса обязательно для заполнения"
	case emptyFieldPrice = "Поле с ценой обязательно для заполнения"
	case emptyFieldDuration = "Поле с продолжительностью услуги обязательно для заполнения"

	case notValidFieldPrice = "Неверный формат цены. Цена должна быть положительным целым или десятичным числом"
}
