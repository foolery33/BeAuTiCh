//
//  ChangeDateTimeStringToHhMm.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 21.06.2023.
//

import Foundation

final class ChangeDateTimeStringToHhMmUseCase {
    
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
}
