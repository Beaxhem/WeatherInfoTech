//
//  HomeViewModel.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

protocol HomeViewModel: ViewModel {
	var cities: [City] { get }
	var query: String { get set }
}

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

	var bindToController: () -> () = {}

	private var cityRepository = CityRepository()

	private let searchResultsQueue = SearchResultsQueue()

	init() {
		self.cities = cityRepository.cities
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
