//
//  CityRepository.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

class CityRepository {

	var cities: [City] = []

	func getAll(completion: @escaping ([City]) -> Void) {
		DispatchQueue.global(qos: .utility).async { [weak self] in
			guard let path = Bundle.main.path(forResource: "city_list", ofType: "json") else { return }
			let url = URL(fileURLWithPath: path)

			guard let data = try? Data(contentsOf: url, options: [.mappedIfSafe]) else { return }

			let cities = (try? JSONDecoder().decode([City].self, from: data)) ?? []
			self?.cities = cities
			completion(cities)
		}
	}

}
