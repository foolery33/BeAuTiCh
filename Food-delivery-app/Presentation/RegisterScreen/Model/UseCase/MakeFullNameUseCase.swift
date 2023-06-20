//
//  MakeFullNameUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class MakeFullNameUseCase {
    
    func makeFullName(firstName: String, lastName: String, patronymic: String) -> String {
        let fullName = "" + (lastName.count > 0 ? lastName + " " : "") + (firstName.count > 0 ? firstName + " " : "") + (patronymic.count > 0 ? patronymic + " " : "")
        return String(fullName.prefix(fullName.count - 1))
        
    }
    
}
