//
//  HomeViewModel.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

protocol HomeViewModel: ViewModel {
	var cities: [City] { get }
	func update()
}

class DefaultHomeViewModel: HomeViewModel {

	var cities: [City] = [] {
		didSet {
			bindToController()
		}
	}

	var bindToController: () -> () = {}

	private var cityRepository = CityRepository()

	init() {
		self.cities = cityRepository.cities
	}

	func update() {
		bindToController()
	}

}
