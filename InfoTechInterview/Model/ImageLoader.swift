//
//  ImageLoader.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class ImageLoader {

	private let cache = NSCache<NSString, UIImage>()
	private let queue = DispatchQueue.global(qos: .utility)

	func loadImage(name: String, completion: @escaping (UIImage) -> Void) {
		if let image = cache.object(forKey: .init(string: name)) {
			completion(image)
			return
		}

		queue.async { [weak self] in
			guard let url = URL(string: "https://infotech.gov.ua/storage/img/\(name)"),
				  let data = try? Data(contentsOf: url),
				  let image = UIImage(data: data) else {
				return
			}
			self?.cache.setObject(image, forKey: .init(string: name))
			completion(image)
		}
	}

}
