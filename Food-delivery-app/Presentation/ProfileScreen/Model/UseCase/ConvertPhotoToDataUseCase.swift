//
//  ConvertPhotoToDataUseCase.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import UIKit

final class ConvertPhotoToDataUseCase {
	
	func getDataPhoto(didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) -> Data {
		if let imageUrl = info[.imageURL] as? URL {
			guard let fileData = readFileDataFromFileURL(fileURL: imageUrl) else { return Data()}
			return fileData
		}

		if let pickedImage = info[.originalImage] as? UIImage {
			if let imageData = pickedImage.jpegData(compressionQuality: 0.8),
			   let imageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.png") {
				do  {
					try? imageData.write(to: imageUrl)
					print("Фотография успешно сохранена: \(imageUrl)")

					guard let fileData = readFileDataFromFileURL(fileURL: imageUrl) else { return Data()}
					return fileData
				}
			}
		}

		return Data()
	}

	private func readFileDataFromFileURL(fileURL: URL) -> Data? {
		do {
			let fileData = try Data(contentsOf: fileURL)
			return fileData
		} catch {
			print("Ошибка чтения файла: \(error.localizedDescription)")
			return nil
		}
	}
}
