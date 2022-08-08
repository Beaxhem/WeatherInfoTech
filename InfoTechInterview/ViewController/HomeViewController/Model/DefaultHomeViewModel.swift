//
//  DefaultHomeViewModel.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

class DefaultHomeViewModel: HomeViewModel {

	var query: String = "" {
		willSet {
			if newValue != query {
				filter(for: newValue)
			}
		}
	}

	var cities: [City] = [] {
		didSet {
			bindToController()
		}
	}

	var isLoaded: Bool = false

	var bindToController: () -> () = {}

	private var cityRepository = CityRepository()

	private let searchResultsQueue = SearchResultsQueue()

	init() {
		self.cities = cityRepository.cities
		cityRepository.getAll { [weak self] cities in
			self?.isLoaded = true
			self?.cities = cities
		}
	}

	func filter(for query: String) {
		searchResultsQueue.add { [weak self] in
			guard let self = self else { return }
			guard query != "" else {
				self.cities = self.cityRepository.cities
				return
			}

			self.cities = self.cityRepository.cities.filter {
				$0.name.starts(with: query)
			}
		}
	}

}
